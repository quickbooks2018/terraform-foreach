variable "securitygroup_name" {}

variable "securitygroup_description" {}

variable "securitygroup_ingress" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    ipv6_cidr_blocks = list(string)
  }))
}