terraform {
  backend "azurerm" {
    resource_group_name      = "NetworkWatcherRG"
    storage_account_name     = "myfirsttrail"
    container_name           = "terraformstate-demo"
    key                      = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = var.subscription_id
}

# resource "azurerm_resource_group" "vnet_resource_group" {
#   name     = var.rg_name
#   location = var.rg_location
# }

data "azurerm_resource_group" "vnet_resource_group" {
  name     = var.rg_name
  # location = var.rg_location
}


resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.vnet_resource_group.location
  resource_group_name = data.azurerm_resource_group.vnet_resource_group.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
}

resource "azurerm_subnet" "vnet_subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.vnet_resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.subnet_address_prefix
}


# resource "azurerm_storage_account" "vnet_storage_account" {
#   name                = var.vnet_storage_account_name
#   resource_group_name = azurerm_resource_group.vnet_resource_group.name

#   location                 = azurerm_resource_group.vnet_resource_group.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   network_rules {
#     default_action             = "Deny"
#     virtual_network_subnet_ids = [azurerm_subnet.vnet_subnet.id]
#   }
# }

data "azurerm_storage_account" "vnet_storage_account"{
  name = var.vnet_storage_account_name
  resource_group_name = data.azurerm_resource_group.vnet_resource_group.name
}


# data "azurerm_client_config" "current_client" {}

# resource "azurerm_key_vault" "key_vault" {
#   name                = var.key_vault_name
#   location            = "West Europe"
#   resource_group_name = data.azurerm_storage_account.vnet_storage_account.resource_group_name
#   soft_delete_retention_days  = 7
#   tenant_id           = data.azurerm_client_config.current_client.tenant_id
#   sku_name            = var.key_vault_sku_name

#   access_policy {
#     tenant_id = data.azurerm_client_config.current_client.tenant_id
#     object_id = data.azurerm_client_config.current_client.object_id

#     certificate_permissions = var.key_vault_certificate_permissions

#     key_permissions = var.key_vault_key_permissions

#     secret_permissions = var.key_vault_secret_permissions

#     storage_permissions = var.key_vault_storage_permissions
#   }
# }

# resource "azurerm_key_vault_secret" "key_vault_secret" {
#   name         = var.key_vault_secret_name
#   value        = data.azurerm_storage_account.vnet_storage_account.primary_connection_string
#   key_vault_id = azurerm_key_vault.key_vault.id
# }


resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = data.azurerm_storage_account.vnet_storage_account.location
  resource_group_name = data.azurerm_storage_account.vnet_storage_account.resource_group_name
  kind                = "FunctionApp"
  reserved            = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
 
}


resource "azurerm_function_app" "function_app" {
  name                      = var.function_app_name
  location                  = data.azurerm_storage_account.vnet_storage_account.location
  resource_group_name       = data.azurerm_storage_account.vnet_storage_account.resource_group_name
  app_service_plan_id       = azurerm_app_service_plan.app_service_plan.id
  storage_account_name      = data.azurerm_storage_account.vnet_storage_account.name
  storage_account_access_key = data.azurerm_storage_account.vnet_storage_account.primary_access_key
  os_type                   = "linux"
  version                   = "~4"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_LAST_FETCH =  var.DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_LAST_FETCH
    DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_USED_CAPACITY =  var.DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_USED_CAPACITY
    TIME_INDEX_FOR_CHECK_LAST_FETCH =  var.TIME_INDEX_FOR_CHECK_LAST_FETCH
    TIME_INDEX_FOR_CHECK_USED_CAPACITY = var.TIME_INDEX_FOR_CHECK_USED_CAPACITY
    FREQ_AUTOMATION_TEST_TYPE =  var.FREQ_AUTOMATION_TEST_TYPE
    FREQ_AUTOMATION_TEST_NUMBER =  var.FREQ_AUTOMATION_TEST_NUMBER
    ALERTS_DOCUMENTATION = var.ALERTS_DOCUMENTATION
    DOCUMENTATION_TABLE = var.DOCUMENTATION_TABLE
    DELETED_ACCOUNTS_TABLE = var.DELETED_ACCOUNTS_TABLE
    DOCUMENTATION_STORAGE_NAME = var.DOCUMENTATION_STORAGE_NAME
    WORKSPACE_ID = var.WORKSPACE_ID
    HTTP_TRIGGER_URL = var.HTTP_TRIGGER_URL
    MAIN_MANAGER = var.MAIN_MANAGER
    ESSENTIAL_TAG = var.ESSENTIAL_TAG
  }
  
  site_config {
    linux_fx_version = "python|3.11"
  }

  identity {
    type = "SystemAssigned"
  }
  
}

resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                = var.logic_app_workflow_name
  location            = data.azurerm_resource_group.vnet_resource_group.location
  resource_group_name = data.azurerm_resource_group.vnet_resource_group.name
}
