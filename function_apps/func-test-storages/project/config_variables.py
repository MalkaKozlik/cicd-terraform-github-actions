import os
from dotenv import load_dotenv

load_dotenv()

time_period_for_check_last_fetch=os.getenv("DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_LAST_FETCH") 
time_period_for_check_used_capacity=os.getenv("DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_USED_CAPACITY") 
time_index_for_check_last_fetch=os.getenv("TIME_INDEX_FOR_CHECK_LAST_FETCH") 
time_index_for_check_used_capacity=os.getenv("TIME_INDEX_FOR_CHECK_USED_CAPACITY") 
connection_string=os.getenv("CONNECTION_STRING") 
freq_automation_test_type=os.getenv("FREQ_AUTOMATION_TEST_TYPE") 
freq_automation_test_number=os.getenv("FREQ_AUTOMATION_TEST_NUMBER") 
alerts_documentation=os.getenv("ALERTS_DOCUMENTATION") 
documentation_table=os.getenv("DOCUMENTATION_TABLE") 
deleted_accounts_table=os.getenv("DELETED_ACCOUNTS_TABLE") 
documentation_storage_name=os.getenv("DOCUMENTATION_STORAGE_NAME") 
documentation_resource_group_name=os.getenv("DOCUMENTATION_RESOURCE_GROUP_NAME") 
sender_email=os.getenv("EMAIL_SENDER") 
sender_email_password=os.getenv("SENDER_EMAIL_PASSWORD") 
smtp_host=os.getenv("SMTP_HOST") 
smtp_port=os.getenv("SMTP_PORT") 
cost_sub=os.getenv("COST") 
workspace_id = os.getenv("WORKSPACE_ID")
essential_tag = os.getenv("ESSENTIAL_TAG")
http_trigger_url = os.getenv("HTTP_TRIGGER_URL")
connection_string_2=os.getenv('CONNECTION_STRING_2')
main_manager=os.getenv('MAIN_MANAGER')

