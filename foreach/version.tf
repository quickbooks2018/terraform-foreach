# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.1.9" # local terraform version # https://developer.hashicorp.com/terraform/tutorials/configuration-language/versions
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
