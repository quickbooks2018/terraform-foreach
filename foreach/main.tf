terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      # greater than or equal to 4.0
      version = ">= 4.55"
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


module "security_group" {
  source = "./dynamicblocks/modules/securitygroups"

  securitygroup_name        = "web"
  securitygroup_description = "web"

  securitygroup_ingress = {

    # Ingress rules for web

      "80" = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "http"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      },

    "443" = {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "https"
      cidr_blocks = ["10.60.0.0/16"]
      ipv6_cidr_blocks = ["::/0"]
    },


    }


}


module "meta_arguments_toset" {
  source = "./meta-aruments/toset"

  vpcs = [

    "10.40.0.0/16", # To set loop on a list
    "10.50.0.0/16",
  ]

}


module "meta_arguments_mapofobjects" {
  source = "./meta-aruments/map_of_objects"

  vpcs = {
    vpc1 = "10.40.0.0/16",
    vpc2 = "10.50.0.0/16",
  }


}