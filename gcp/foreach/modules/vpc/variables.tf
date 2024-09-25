variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "vpcs" {
  type = map(object({
    name                    = string
    auto_create_subnetworks = bool
    routing_mode            = string
    description             = string
    delete_default_routes_on_create = bool
    mtu                     = number
    tags                    = list(string)
  }))
  description = "Map of VPC configurations"
}