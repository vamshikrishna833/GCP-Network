output "private_network" {
  value = google_compute_network.shared_network.id
}

output "private_network_name" {
  value = google_compute_network.shared_network.name
}

output "host_project_id" {
  value = google_compute_network.shared_network.project
}