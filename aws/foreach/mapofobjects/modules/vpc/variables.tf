# https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
variable "vpcs" {
  type = map(object({
    cidr = string
    tags = map(string)
    tenancy = string
  }))
}
