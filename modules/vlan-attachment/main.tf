resource "google_compute_interconnect_attachment" "on_prem" {
  name         = "${var.prefix}-${var.vlan_interconnect_type}"
  router       = google_compute_router.main.id
  type         = var.vlan_interconnect_type
  project = var.project_id
}

resource "google_compute_router" "main" {
  name    = "${var.prefix}-router"
  network = var.vpc_network
  project = var.project_id
  bgp {
    asn               = var.asn
    # advertise_mode    = "CUSTOM"
    # advertised_groups = ["ALL_SUBNETS"]
    # advertised_ip_ranges {
    #   range = "1.2.3.4"
    # }
    # advertised_ip_ranges {
    #   range = "6.7.0.0/16"
    # }
  }
}