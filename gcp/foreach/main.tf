module "vpc" {
  source = "./modules/vpc"

  project_id = var.project_id

  vpcs = {
    vpc1 = {
      name                            = "vpc-network-1"
      auto_create_subnetworks         = false
      routing_mode                    = "GLOBAL"
      description                     = "VPC Network 1"
      delete_default_routes_on_create = false
      mtu                             = 1460
      tags                            = ["vpc1", "production"]
    },
    vpc2 = {
      name                            = "vpc-network-2"
      auto_create_subnetworks         = true
      routing_mode                    = "REGIONAL"
      description                     = "VPC Network 2"
      delete_default_routes_on_create = true
      mtu                             = 1500
      tags                            = ["vpc2", "development"]
    }
  }
}