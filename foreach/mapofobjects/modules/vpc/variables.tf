variable "vpcs" {
  type = map(object({
    cidr = string
    tags = map(string)
    tenancy = string
  }))
}