terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }

  }
}

provider "aws" {
    region = "us-east-1"
}

terraform {
  required_version = "~> 1.0"
}


module "vpcs" {
  source = "./mapofobjects/modules/vpc"

  vpcs = {

    "vpc1" = {
      cidr    = "10.10.0.0/16"
      tenancy = "default"
      tags    = {
        Name = "vpc1"
      }
    }

    "vpc2" = {
      cidr    = "10.20.0.0/16"
      tenancy = "default"
      tags    = {
        Name = "vpc2"
      }
    }


  }

}