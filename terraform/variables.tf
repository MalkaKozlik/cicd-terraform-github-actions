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

variable app_service_plan_name{
  type = string
  default = "app-storage-accounts"
}

variable function_app_name {
  type        = string
  default = "func-storage-accounts"
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
  default     = "days"
}

variable TIME_INDEX_FOR_CHECK_USED_CAPACITY {
  type        = string
  default     = "days"
}

variable FREQ_AUTOMATION_TEST_TYPE {
  type        = string
  default     = "weeks"
}

variable FREQ_AUTOMATION_TEST_NUMBER {
  type        = number
  default = 1
}

variable ESSENTIAL_TAG {
  type        = string
  default = "essential"
}

variable ALERTS_DOCUMENTATION {
  type        = string
  default     = "alertsDocumentation"
}

variable DOCUMENTATION_TABLE {
  type        = string
  default     = "documentation"
}

variable DELETED_ACCOUNTS_TABLE {
  type        = string
  default     = "deletedStorages"
}

variable DOCUMENTATION_STORAGE_NAME {
  type        = string
  default     = "myfirsttrail"
}



variable logic_app_workflow_name {
  type        = string
  default = "logic-app-storage-management"
}


variable key_vault_name {
  type        = string
  default = "kv-mange-storages"
}

variable key_vault_sku_name {
  type        = string
  default     = "standard"
}

variable key_vault_certificate_permissions {
  type        = list
  default = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore"]
}

variable key_vault_key_permissions {
  type        = list
  default = ["Create","Get"]
}

variable key_vault_secret_permissions {
  type        = list
  default = ["Get","Set","Delete","Purge","Recover"]
}

variable key_vault_storage_permissions {
  type        = list
  default =  ["Get", ]
}

variable key_vault_secret_name {
  type        = string
  default     = "CONNECTION-STRING"
}
