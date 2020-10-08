locals {
  local_network_name = element(reverse(split("/", var.local_network)), 0)
  peer_network_name  = element(reverse(split("/", var.peer_network)), 0)
}

data "google_compute_network" "vpc-1" {
  name    = var.local_network
  project = var.vpc1_project_id
}
data "google_compute_network" "vpc-2" {
  name    = var.peer_network
  project = var.vpc2_project_id
}

resource "google_compute_network_peering" "local_network_peering" {
  provider             = var.provider_local_network
  name                 = "${var.prefix}-${local.local_network_name}-${local.peer_network_name}"
  network              = data.google_compute_network.vpc-1.self_link
  peer_network         = data.google_compute_network.vpc-2.self_link
}

resource "google_compute_network_peering" "peer_network_peering" {
  provider             = var.provider_peer_network
  name                 = "${var.prefix}-${local.peer_network_name}-${local.local_network_name}"
  network              = data.google_compute_network.vpc-2.self_link
  peer_network         = data.google_compute_network.vpc-1.self_link

  depends_on = ["google_compute_network_peering.local_network_peering"]
}
