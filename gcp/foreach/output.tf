output "vpc_networks" {
  description = "The created VPC networks"
  value       = module.vpc.vpc_networks
}