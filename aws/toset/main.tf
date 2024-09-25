module "vpc" {
  source = "modules/vpc"

  vpc_cidrs = [
    "10.200.0.0/16",
    "10.220.0.0/16",
    "10.230.0.0/16",
    "10.200.0.0/16"  # Duplicate CIDR, will be ignored by toset
  ]

  vpc_tenancy = "default"

  vpc_names = [
    "Production-VPC",
    "Development-VPC",
    "Testing-VPC",
    "Ignored-VPC"  # This name won't be used due to duplicate CIDR
  ]

}