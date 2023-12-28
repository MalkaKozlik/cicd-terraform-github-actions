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
  default = "kv-manage-storages"
}

variable key_vault_resource_group_name {
  type        = string
  default     = "NetworkWatcherRG"
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

# variable key_vault_secret_name {
#   type        = string
#   default     = "CONNECTION-STRING-STORAGES"
# }

variable key_vault_secret_name {
  type        = string
  default     = "CONNECTION-STRING"
}

variable app_service_plan_name{
  type = list(string)
  default = ["app-log-analytics","app-start-function","app-for-each-subscription","app-test-storages","app-end-function"]
}

variable function_app_name {
  type        = list(string)
  default = ["func-log-analytics","func-start-function","func-for-each-subscription","func-test-storages","func-end-function"]
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

variable logic_app_workflow_name {
  type        = string
  default = "logic-app-storage-management"
}

