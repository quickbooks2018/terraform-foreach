variable "vpc_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for VPCs"
}

variable "vpc_names" {
  type        = list(string)
  description = "List of names for VPCs"
}

variable "vpc_tenancy" {
  type        = string
  default     = "default"
  description = "Tenancy for all VPCs"
}