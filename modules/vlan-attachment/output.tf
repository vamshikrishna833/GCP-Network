output "router_id" {
  value = google_compute_router.main.id
}

output "router_gateway_ip" {
  value = google_compute_router.main.gateway_ipv4
}

output "vlan_attachment_id" {
  value = google_compute_interconnect_attachment.on_prem.id
}

output "vlan_attachment_key" {
  value = google_compute_interconnect_attachment.on_prem.pairing_key
}

output "vlan_attachment_asn" {
  value = google_compute_interconnect_attachment.on_prem.partner_asn
}