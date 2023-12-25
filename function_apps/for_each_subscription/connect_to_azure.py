from azure.data.tables import TableClient
from azure.core.exceptions import ResourceNotFoundError
from azure.identity import DefaultAzureCredential
from azure.mgmt.storage import StorageManagementClient
from azure.mgmt.monitor import MonitorManagementClient
from azure.mgmt.subscription import SubscriptionClient
from azure.monitor.query import LogsQueryClient, LogsQueryStatus


def find_resource_group_name(storage_account_id):
    if storage_account_id.find("resourceGroups") != -1 :
        resource_group_name = (storage_account_id[storage_account_id.find("resourceGroups") + 15:
        storage_account_id.find("/",storage_account_id.find("resourceGroups") + 15)])
    else:
        resource_group_name = ""
    return resource_group_name


def create_log_query_client():
    log_query_client=LogsQueryClient(credential=DefaultAzureCredential())
    return log_query_client


def create_monitor_management_client(sub_id):
    monitor_client = MonitorManagementClient(
        credential=DefaultAzureCredential(), subscription_id=sub_id
    )
    return monitor_client


def create_storage_management_client(sub_id):
    storage_client = StorageManagementClient(
        credential=DefaultAzureCredential(), subscription_id=sub_id
    )
    return storage_client


def create_subscription_client():
    subscription_client = SubscriptionClient(credential=DefaultAzureCredential())
    return subscription_client


def find_resource_group_name(storage_account_id):
    if storage_account_id.find("resourceGroups") != -1:
        resource_group_name = storage_account_id[
            storage_account_id.find("resourceGroups")
            + 15 : storage_account_id.find(
                "/", storage_account_id.find("resourceGroups") + 15
            )
        ]
    else:
        resource_group_name = ""
    return resource_group_name
