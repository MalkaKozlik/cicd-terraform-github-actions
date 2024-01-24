resource "azurerm_resource_group" "resource"{
  name     = var.resource_group_name
  location = var.resource_group_location
}

output id {
  value       = azurerm_resource_group.resource.id
}

output resource_group_name {
  value       = var.hello
}
