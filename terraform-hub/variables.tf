variable subscription_id {
  type        = string
}

variable virtual_networks_names {
  type        = list
  default     = ["vnet-storages","vnet-subscriptions","vnet-emails","vnet-administrator"]
}

variable virtual_networks_address_space {
  type        = list(string)
  default     = ["172.16.0.0/16","172.17.0.0/16","172.18.0.0/16","172.19.0.0/16"]
}


variable virtual_hub_connection_names {
  type        = list
  default     = ["vhub-connection-storages","vhub-connection-subscriptions","vhub-connection-emails","vhub-connection-administrator"]
}
