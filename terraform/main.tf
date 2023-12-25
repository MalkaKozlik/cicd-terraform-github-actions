terraform {
  backend "azurerm" {
    resource_group_name      = "NetworkWatcherRG"
    storage_account_name     = "myfirsttrail"
    container_name           = "terraform-demo"
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


data "azurerm_client_config" "current_client" {}

resource "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  location            = "West Europe"
  resource_group_name = data.azurerm_storage_account.vnet_storage_account.resource_group_name
  soft_delete_retention_days  = 7
  tenant_id           = data.azurerm_client_config.current_client.tenant_id
  sku_name            = var.key_vault_sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current_client.tenant_id
    object_id = data.azurerm_client_config.current_client.object_id

    certificate_permissions = var.key_vault_certificate_permissions

    key_permissions = var.key_vault_key_permissions

    secret_permissions = var.key_vault_secret_permissions

    storage_permissions = var.key_vault_storage_permissions
  }
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = var.key_vault_secret_name
  value        = data.azurerm_storage_account.vnet_storage_account.primary_connection_string
  key_vault_id = azurerm_key_vault.key_vault.id
}


resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name[count.index]
  location            = data.azurerm_storage_account.vnet_storage_account.location
  resource_group_name = data.azurerm_storage_account.vnet_storage_account.resource_group_name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Premium"
    size = "P1V2"
  }

  count = length(var.app_service_plan_name)
  
}

# ["log-analytics","start-function","for-each-subsription","test-storages","end-function"]
resource "azurerm_function_app" "function_app" {
  name                      =  var.function_app_name[count.index]
  location                  = data.azurerm_storage_account.vnet_storage_account.location
  resource_group_name       = data.azurerm_storage_account.vnet_storage_account.resource_group_name
  app_service_plan_id       = azurerm_app_service_plan.app_service_plan[count.index].id
  storage_account_name      = data.azurerm_storage_account.vnet_storage_account.name
  storage_account_access_key = data.azurerm_storage_account.vnet_storage_account.primary_access_key
  version                   = "~4"

  app_settings = count.index==0 ? {
    FUNCTIONS_WORKER_RUNTIME = "python"

    DESIRED_TIME_PERIOD_SINCE_LAST_RETRIEVAL_FOR_CHECK_LAST_FETCH=30
    TIME_INDEX_FOR_CHECK_LAST_FETCH="days"
    WORKSPACE_ID="fa9e707a-28c1-4528-b7b2-54d03360d4c9"

    SECRET = " "
    KEYVAULT_NAME = " "
    KEYVAULT_URI = " "
    https_only                          = true
    DOCKER_REGISTRY_SERVER_URL          = var.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME     = var.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.DOCKER_REGISTRY_SERVER_PASSWORD
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  } : count.index==1 ? {
    FUNCTIONS_WORKER_RUNTIME = "python"

    CONNECTION_STRING = data.azurerm_storage_account.vnet_storage_account.primary_connection_string
    DOCUMENTATION_TABLE = "documentation"
  
    SECRET = " "
    KEYVAULT_NAME = " "
    KEYVAULT_URI = " "
    https_only                          = true
    DOCKER_REGISTRY_SERVER_URL          = var.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME     = var.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.DOCKER_REGISTRY_SERVER_PASSWORD
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  } : count.index==2 ? {
    FUNCTIONS_WORKER_RUNTIME = "python"

    ESSENTIAL_TAG=''
  
    SECRET = " "
    KEYVAULT_NAME = " "
    KEYVAULT_URI = " "
    https_only                          = true
    DOCKER_REGISTRY_SERVER_URL          = var.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME     = var.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.DOCKER_REGISTRY_SERVER_PASSWORD
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  }: count.index==3 ? {
    FUNCTIONS_WORKER_RUNTIME = "python"
  
    SECRET = " "
    KEYVAULT_NAME = " "
    KEYVAULT_URI = " "
    https_only                          = true
    DOCKER_REGISTRY_SERVER_URL          = var.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME     = var.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.DOCKER_REGISTRY_SERVER_PASSWORD
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  } : count.index==4 ? {
    FUNCTIONS_WORKER_RUNTIME = "python"

    CONNECTION_STRING=data.azurerm_storage_account.vnet_storage_account.primary_connection_string
    EXCEL_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=sachayasubscriptiof6c98f;AccountKey=7VR6ivUm5kKambo7z4sEkrjEL8zx/CjYXz+9f9qwBi6ATKs4LBSbHPajZJF5DnG5LrVJQ7+rQ7Uc+AStDAwauA==;EndpointSuffix=core.windows.net"
    #HTTP_TRIGGER_URL = function_app_email
    HTTP_TRIGGER_URL="https://func-try-2.azurewebsites.net/api/HttpTrigger1?code=vqQyTSrot8Byr3-PUAWsHWWUBRImjzQp9DO_i8itYgKmAzFueI86Pg=="
    MAIN_MANAGER=" "
    DOCUMENTATION_TABLE ="documentation"
    DELETED_ACCOUNTS_TABLE="deletedStorages"

    SECRET = " "
    KEYVAULT_NAME = " "
    KEYVAULT_URI = " "
    https_only                          = true
    DOCKER_REGISTRY_SERVER_URL          = var.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME     = var.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.DOCKER_REGISTRY_SERVER_PASSWORD
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  }

  site_config {
    always_on         = true
    linux_fx_version  = var.linux_fx_version 
  } 

  identity {
    type = "SystemAssigned"
  }
  count= length(var.function_app_name)
}

resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                = var.logic_app_workflow_name
  location            = data.azurerm_resource_group.vnet_resource_group.location
  resource_group_name = data.azurerm_resource_group.vnet_resource_group.name
}
