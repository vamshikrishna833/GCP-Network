data "google_compute_network" "network" {
  name    = var.network_name
  project = var.project_id
}

data "google_compute_router" "vlan-router" {
  name    = var.router_name
  network = data.google_compute_network.network.self_link
}

resource "google_compute_interconnect_attachment" "on_prem" {
  name   = "on-prem-attachment"
  router = data.google_compute_router.vlan-router.id
}
