# vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
# Security group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# terraform dynamic blocks
# https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks

resource "aws_vpc" "main" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}




resource "aws_security_group" "allow_tls" {
  name        = var.securitygroup_name
  description = var.securitygroup_description
  vpc_id      = aws_vpc.main.id


  dynamic "ingress" {
    for_each = var.securitygroup_ingress
    content {
      description      = ingress.value.description       # dynamic block name is ingress
      from_port        = ingress.value.from_port         # dynamic block name is ingress
      to_port          = ingress.value.to_port           # dynamic block name is ingress
      protocol         = ingress.value.protocol          # dynamic block name is ingress
      cidr_blocks      = ingress.value.cidr_blocks       # dynamic block name is ingress
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks  # dynamic block name is ingress
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.securitygroup_name
  }
}
