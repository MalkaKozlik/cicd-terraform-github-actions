terraform {
  backend "azurerm" {
    resource_group_name      = "NetworkWatcherRG"
    storage_account_name     = "myfirsttrail"
    container_name           = "terraform-hub-demo"
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


resource "azurerm_resource_group" "resource_group" {
  name     = "example-resource-group"
  location = "West Europe"
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_networks_names[count.index]
  address_space       = var.virtual_networks_address_space[count.index]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  count = length(var.virtual_networks_names)
}

resource "azurerm_virtual_wan" "virtual_wan" {
  name                = "vwan-example"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

resource "azurerm_virtual_hub" "virtual_hub" {
  name                = "virtual-hub"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan.id
  address_prefix      = "10.0.1.0/24"
}

resource "azurerm_virtual_hub_connection" "virtual_hub_connection" {
  name                      = var.virtual_hub_connection_names[count.index]
  virtual_hub_id            = azurerm_virtual_hub.virtual_hub.id
  remote_virtual_network_id = azurerm_virtual_network.virtual_network[count.index].id
  count= length(var.virtual_hub_connection_names)
}