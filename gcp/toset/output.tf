output "vpc_networks" {
  description = "The created VPC networks"
  value       = module.vpc.vpc_networks
}

output "vpc_subnetworks" {
  description = "The created VPC subnetworks"
  value       = module.vpc.vpc_subnetworks
}