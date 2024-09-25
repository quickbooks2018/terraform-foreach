# https://developer.hashicorp.com/terraform/language/functions/toset
resource "aws_vpc" "main" {
  for_each = toset(var.vpc_cidrs)

  cidr_block       = each.value
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = var.vpc_names[index(var.vpc_cidrs, each.value)]
  }
}