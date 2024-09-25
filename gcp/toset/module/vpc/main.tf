resource "google_compute_network" "vpc_network" {
  for_each = toset([for vpc in var.vpcs : vpc.name])

  project                         = var.project_id
  name                            = each.key
  auto_create_subnetworks         = var.vpcs[index(var.vpcs.*.name, each.key)].auto_create_subnetworks
  routing_mode                    = var.vpcs[index(var.vpcs.*.name, each.key)].routing_mode
  description                     = var.vpcs[index(var.vpcs.*.name, each.key)].description
  delete_default_routes_on_create = var.vpcs[index(var.vpcs.*.name, each.key)].delete_default_routes_on_create
  mtu                             = var.vpcs[index(var.vpcs.*.name, each.key)].mtu

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "google_compute_subnetwork" "subnetwork" {
  for_each = toset([for vpc in var.vpcs : vpc.name])

  name          = "${each.key}-subnet"
  ip_cidr_range = var.vpcs[index(var.vpcs.*.name, each.key)].cidr
  region        = var.region
  network       = google_compute_network.vpc_network[each.key].id
  project       = var.project_id
}