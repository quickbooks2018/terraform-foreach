variable "project_id" {
  type        = string
  default     = "playground-s-11-8e2837f9"
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  type        = string
  default     = "us-central-1"
  description = "The region where resources will be created"
}