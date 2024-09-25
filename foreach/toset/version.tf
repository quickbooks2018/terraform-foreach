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
  required_version = "1.9.6"
}