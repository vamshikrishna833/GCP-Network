
resource "google_compute_network_peering" "commom-host-project" {
  name         = "commom-to-prod-project"
  network      = "${data.google_compute_network.first.self_link}"
  peer_network = "${data.google_compute_network.second.self_link}"
}

resource "google_compute_network_peering" "prod-host-project" {
  name         = "prod-to-common-project"
  network      = "${data.google_compute_network.second.self_link}"
  peer_network = "${data.google_compute_network.first.self_link}"
}

data "google_compute_network" "first" {
  name = "${var.source_project_network_name}"
  project="${var.source_project_name}"
}
data "google_compute_network" "second" {
  name = "${var.dest_project_network_name}"
  project="${var.dest_project_name}"
}
