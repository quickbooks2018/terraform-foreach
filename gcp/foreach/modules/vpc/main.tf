resource "google_compute_network" "vpc_network" {
  for_each = var.vpcs

  project                         = var.project_id
  name                            = each.value.name
  auto_create_subnetworks         = each.value.auto_create_subnetworks
  routing_mode                    = each.value.routing_mode
  description                     = each.value.description
  delete_default_routes_on_create = each.value.delete_default_routes_on_create
  mtu                             = each.value.mtu

  dynamic "timeouts" {
    for_each = each.value.tags != null ? [1] : []
    content {
      create = "10m"
      update = "10m"
      delete = "10m"
    }
  }
}