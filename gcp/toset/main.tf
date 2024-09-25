module "vpc" {
  source = "./module/vpc"

  project_id = var.project_id
  region     = var.region

  vpcs = [
    {
      name                            = "vpc-network-1"
      cidr                            = "10.0.0.0/16"
      auto_create_subnetworks         = false
      routing_mode                    = "GLOBAL"
      description                     = "VPC Network 1"
      delete_default_routes_on_create = false
      mtu                             = 1460
    },
    {
      name                            = "vpc-network-2"
      cidr                            = "10.1.0.0/16"
      auto_create_subnetworks         = false
      routing_mode                    = "REGIONAL"
      description                     = "VPC Network 2"
      delete_default_routes_on_create = true
      mtu                             = 1500
    },
    {
      name                            = "vpc-network-3"
      cidr                            = "10.2.0.0/16"
      auto_create_subnetworks         = false
      routing_mode                    = "GLOBAL"
      description                     = "VPC Network 3"
      delete_default_routes_on_create = false
      mtu                             = 1460
    }
  ]
}