variable resource_group_name {
  type        = string
}

variable resource_group_location {
  type        = string
}

variable hello{
  type = string
  default = var.resource_group_name
}

