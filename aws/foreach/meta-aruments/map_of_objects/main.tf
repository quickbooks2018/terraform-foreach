# vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "main" {
  for_each       = var.vpcs
  cidr_block     = each.value
  instance_tenancy = "default"
  tags = {
    Name = each.key
  }
}


