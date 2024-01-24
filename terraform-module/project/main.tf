terraform {
  backend "azurerm" {
    resource_group_name      = "NetworkWatcherRG"
    storage_account_name     = "myfirsttrail"
    container_name           = "terraform-modules-demo"
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


module storages {
    source = "../modules/storages"
    resource_group_name = "terraform-module-try"
    resource_group_location = "West Europe"
}

output id {
  value       = module.storages.id
}

output resource_group {
  value       = module.storages.resource_group_name
 
}

