output "vpc_networks" {
  description = "The created VPC networks"
  value       = google_compute_network.vpc_network
}

output "vpc_subnetworks" {
  description = "The created VPC subnetworks"
  value       = google_compute_subnetwork.subnetwork
}