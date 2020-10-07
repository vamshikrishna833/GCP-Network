locals {
  local_network_name = element(reverse(split("/", var.local_network)), 0)
  peer_network_name  = element(reverse(split("/", var.peer_network)), 0)
}

resource "google_compute_network_peering" "local_network_peering" {
  provider             = google-beta
  name                 = "${var.prefix}-${local.local_network_name}-${local.peer_network_name}"
  network              = var.local_network
  peer_network         = var.peer_network

}

resource "google_compute_network_peering" "peer_network_peering" {
  provider             = google-beta
  name                 = "${var.prefix}-${local.peer_network_name}-${local.local_network_name}"
  network              = var.peer_network
  peer_network         = var.local_network

  depends_on = ["google_compute_network_peering.local_network_peering"]
}
