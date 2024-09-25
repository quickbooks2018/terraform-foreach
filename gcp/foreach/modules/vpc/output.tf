output "vpc_networks" {
  description = "The created VPC networks"
  value       = google_compute_network.vpc_network
}

output "vpc_network_names" {
  description = "The names of the VPC networks"
  value       = { for k, v in google_compute_network.vpc_network : k => v.name }
}

output "vpc_network_ids" {
  description = "The IDs of the VPC networks"
  value       = { for k, v in google_compute_network.vpc_network : k => v.id }
}