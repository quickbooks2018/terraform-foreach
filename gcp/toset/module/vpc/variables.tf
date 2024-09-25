variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  type        = string
  description = "The region where resources will be created"
  default     = "us-central1"
}

variable "vpcs" {
  type = list(object({
    name                            = string
    cidr                            = string
    auto_create_subnetworks         = bool
    routing_mode                    = string
    description                     = string
    delete_default_routes_on_create = bool
    mtu                             = number
  }))
  description = "List of VPC configurations"
}