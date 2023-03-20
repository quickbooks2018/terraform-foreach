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

