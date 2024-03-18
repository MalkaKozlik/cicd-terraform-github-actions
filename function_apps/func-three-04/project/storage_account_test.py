from datetime import datetime

from config.config_variables import documentation_table
from project.alert_reason_enum import alert_reasons
from project.connect_to_azure import *
from project.last_fetch_time import *
from project.send_alert_email import *
from project.used_capacity_comparison import *


def storage_account_test(storage_account,partitionKey,row_key,subscription_id,subscription_name,storage_account_id,last_fetch_time):
    logging.warn('in storage_account_test')
    storage_client = create_storage_management_client(subscription_id)
    # logging.warn(f"storage_client: {storage_client}")
    resource_group_name = find_resource_group_name(storage_account_id)
    # logging.warn(f"resource_group_name: {resource_group_name}")
    used_capacity_comparison_test_result = used_capacity_comparison_test(resource_group_name, storage_account, subscription_id)
    # logging.warn(f"used_capacity_comparison_test_result: {used_capacity_comparison_test_result}")
    last_fetch_is_early_result = check_last_fetch_is_early(storage_client,used_capacity_comparison_test_result["resource_group"],storage_account,last_fetch_time)
    # logging.warn(f"last_fetch_is_early_result: {last_fetch_is_early_result}")

    alert_reason_for_check_used_capacity = (
        alert_reasons.USED_CAPACITY.value
        if used_capacity_comparison_test_result["alert"]
        else "null"
    )
    alert_reason_for_check_last_fetch = (
        alert_reasons.LAST_FETCH_TIME.value
        if last_fetch_is_early_result["alert"]
        else "null"
    )
    logging.info(f"creating")
    entity = creating_an_object_for_sending_to_a_documentation_table(
        str(partitionKey),
        str(row_key),
        datetime.today(),
        subscription_id,
        resource_group_name,
        storage_account,
        used_capacity_comparison_test_result["current_used_storage_capacity"],
        last_fetch_is_early_result["last_fetch_time"],
        used_capacity_comparison_test_result["alert"],
        alert_reason_for_check_used_capacity,
        last_fetch_is_early_result["alert"],
        alert_reason_for_check_last_fetch,
    )
    logging.warn("before upload")
    logging.warn(documentation_table)
    logging.warn(entity)
    upload_to_table(documentation_table, entity)
    logging.info('after-------')
    try:
        object_for_alerts_to_excel= check_alert(
        used_capacity_comparison_test_result["alert"],
        last_fetch_is_early_result["alert"],
        storage_account,
        partitionKey,
        row_key,
        subscription_name
        )

    except Exception as e:
        raise e

    return object_for_alerts_to_excel


def check_alert(
    used_capacity_comparison_test_result,
    last_fetch_is_early_result,
    storage_name,
    partitionKey,
    row_key,
    subscription_name
):
    
    alert = used_capacity_comparison_test_result or last_fetch_is_early_result

    if alert:
        alert_reason = (
            alert_reasons.USED_CAPACITY.value
            if used_capacity_comparison_test_result
            else ""
        )
        alert_reason += (
            " and " if last_fetch_is_early_result and alert_reason != "" else ""
        )
        alert_reason += (
            alert_reasons.LAST_FETCH_TIME.value if last_fetch_is_early_result else ""
        )
        if alert_reason != '':
            alert_reason = ":storage account "+storage_name+"\n"+alert_reason
            try:
                object_for_alerts_to_excel=main_alerts(storage_name, alert_reason,partitionKey,row_key,subscription_name)
                return object_for_alerts_to_excel
            
            except Exception as e:
                raise e
            
    return {"storage_account": storage_name ,"alert_body":"null"}


def creating_an_object_for_sending_to_a_documentation_table(
    partitionKey,
    row_key,
    test_date,
    subscription_id,
    resource_group,
    storage_name,
    current_storage_used_capacity,
    last_storage_fetch_time,
    alert_for_check_used_capacity,
    alert_reason_for_check_used_capacity,
    alert_for_check_last_fetch,
    alert_reason_for_check_last_fetch,
):
    obj = {
        "PartitionKey": partitionKey,
        "RowKey": row_key,
        "test_date": test_date,
        "subscription_id": subscription_id,
        "resource_group": resource_group,
        "storage_name": storage_name,
        "used_storage_capacity": current_storage_used_capacity,
        "alert_for_check_used_capacity": alert_for_check_used_capacity,
        "alert_reason_for_check_used_capacity": alert_reason_for_check_used_capacity,
        "alert_for_check_last_fetch": alert_for_check_last_fetch,
        "alert_reason_for_check_last_fetch": alert_reason_for_check_last_fetch,
    }
    if last_storage_fetch_time:
        obj["last_storage_fetch_time"] = last_storage_fetch_time

    logging.warning(f"obj!!!:  {obj}")
    return obj
