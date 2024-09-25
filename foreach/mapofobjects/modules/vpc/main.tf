# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

# variables types
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
resource "aws_vpc" "main" {
    for_each = var.vpcs
    cidr_block = each.value["cidr"] # double quotes "" are must
    instance_tenancy = each.value["tenancy"] # double quotes "" are must
    tags = each.value["tags"] # double quotes "" are must
}
