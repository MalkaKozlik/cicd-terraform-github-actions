# start secret
variable subscription_id {
  type        = string
}

variable WORKSPACE_ID {
  type        = string
}

variable HTTP_TRIGGER_URL {
  type        = string
}

variable MAIN_MANAGER {
  type        = string
}

# end secrets
variable rg_name {
  type        = string
  default = "NetworkWatcherRG"
}

variable rg_location {  
  type        = string
  default = "West Europe"
}


variable vnet_name {
  type        = string
  default = "vnet-manage-storages"
}

variable address_space {
  type        = list
  default = ["10.1.0.0/16"]
}

variable dns_servers {
  type        = list
  default = []
}

variable subnet_name {
  type        = string
  default = "snet-manage-storages"
}

variable subnet_address_prefix {
  type        = list
  default = ["10.1.1.0/24"]
}

variable vnet_storage_account_name {
  type        = string
  default =  "myfirsttrail"
}

variable key_vault_name {
  type        = string
  default = "kv-connection-string1"
}

variable key_vault_resource_group_name {
  type        = string
  default     = "rg-administrators"
}


# variable key_vault_sku_name {
#   type        = string
#   default     = "standard"
# }

# variable key_vault_certificate_permissions {
#   type        = list
#   default = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore"]
# }

# variable key_vault_key_permissions {
#   type        = list
#   default = ["Create","Get"]
# }

# variable key_vault_secret_permissions {
#   type        = list
#   default = ["Get","Set","Delete","Purge","Recover"]
# }

# variable key_vault_storage_permissions {
#   type        = list
#   default =  ["Get", ]
# }

# variable key_vault_secret_name {
#   type        = string
#   default     = "CONNECTION-STRING-STORAGES"
# }

variable key_vault_secret_name {
  type        = string
  default     = "CONNECTION-STRING-MANAGEMENT-STORAGES"
}

variable key_vault_secret_excel_name {
  type        = string
  default     = "ADMINISTRATORS-SECRET"
}


variable app_service_plan_name{
  type = list(string)
  default = ["app-get-last-fetch-time-for-each-storage-account","app-get-subscription-list","app-get-storage-list-by-subscription","app-test-storage","app-send-excel-mark-delete"]
}

variable function_app_name {
  type        = list(string)
  default = ["func-get-last-fetch-time-for-each-storage-account","func-get-subscription-list","func-get-storage-list-by-subscription","func-test-storage","func-send-excel-mark-delete"]
}

variable DOCKER_REGISTRY_SERVER_PASSWORD {
  type        = string
}

variable DOCKER_REGISTRY_SERVER_USERNAME {
  type        = string
}


variable DOCKER_REGISTRY_SERVER_URL {
  type        = string
}

variable linux_fx_version {
  type        = string
  default     = "DOCKER|mcr.microsoft.com/azure-functions/dotnet:4-appservice-quickstart"
}

variable IMAGE_NAME {
  type        = string
  default     = "mcr.microsoft.com/azure-functions/dotnet"
}

variable IMAGE_TAG {
  type        = string
  default     = "4-appservice-quickstart"
}

variable DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_LAST_FETCH {
  type        = string
  default     = "30"
}

variable DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_USED_CAPACITY {
  type        = string
  default     = "30"
}

variable TIME_INDEX_FOR_CHECK_LAST_FETCH {
  type        = string
  default     = "Day"
  validation {
    condition     = contains(["Year","Month","Week","Day","Hour","Minute","Second"], var.TIME_INDEX_FOR_CHECK_LAST_FETCH)
    error_message = "Valid values for var: TIME_INDEX_FOR_CHECK_LAST_FETCH are (Year,Month,Week,Day,Hour,Minute,Second)."
  } 
}

variable TIME_INDEX_FOR_CHECK_USED_CAPACITY {
  type        = string
  default     = "Day"
  validation {
    condition     = contains(["Year","Month","Week","Day","Hour","Minute","Second"], var.TIME_INDEX_FOR_CHECK_USED_CAPACITY)
    error_message = "Valid values for var: TIME_INDEX_FOR_CHECK_USED_CAPACITY are (Year,Month,Week,Day,Hour,Minute,Second)."
  } 
}

variable FREQ_AUTOMATION_TEST_TYPE {
  type        = string
  default = "Week"
  validation {
    condition     = contains(["Month","Week","Day","Hour","Minute","Second"], var.FREQ_AUTOMATION_TEST_TYPE)
    error_message = "Valid values for var: FREQ_AUTOMATION_TEST_TYPE are (Month,Week,Day,Hour,Minute,Second)."
  } 
}

variable FREQ_AUTOMATION_TEST_NUMBER {
  type        = number
  default = 1
}

variable logic_app_workflow_name {
  type        = string
  default = "logic-app-storage-management"
}
