/******************************************
  Locals configuration
 *****************************************/
locals {
  api_set_host        = var.enable_apis ? toset(var.activate_apis_host) : []
  api_set_service     = var.enable_apis ? toset(var.activate_apis_service) : []
  s_account_fmt       = "${format("serviceAccount:%s", google_service_account.default_service_account.email)}"
  api_s_account       = "${format("%s@cloudservices.gserviceaccount.com", var.service_project_number)}"
  api_ser_account_fmt = "${format("serviceAccount:%s", local.api_s_account)}"
}

/*****************************************
 APIs needs to be enabled for all new projects.
*****************************************/

resource "google_project_service" "host_project" {
  for_each                   = local.api_set_host
  project                    = var.host_project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services

}


resource "google_project_service" "service_project" {
  for_each                   = local.api_set_service
  project                    = var.service_project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services
}

/*****************************************
 Create the hosted network.
*****************************************/

resource "google_compute_network" "shared_network" {
  name                    = var.shared_network_name
  auto_create_subnetworks = "false"
  project                 = var.host_project_id

  depends_on = [
    google_compute_shared_vpc_service_project.service_project_1,
  ]
}


/*****************************************
 Create the subnets in shared network
*****************************************/

resource "google_compute_subnetwork" "subnetwork1" {
  region                   = var.region
  project                  = var.host_project_id
  network                  = google_compute_network.shared_network.self_link
  name                     = var.shared_subnet_name
  ip_cidr_range            = var.shared_subnet_cidr
  private_ip_google_access = true

}

/******************************************
 Allow the hosted network to be hit over ICMP, SSH, and HTTP.
*****************************************/

resource "google_compute_firewall" "shared_network" {
  name    = "allow-ssh-and-icmp"
  network = google_compute_network.shared_network.self_link
  project = google_compute_network.shared_network.project

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}


/*****************************************
 Enable shared VPC hosting in the host project.
*****************************************/

resource "google_compute_shared_vpc_host_project" "host_project" {
  project = var.host_project_id
}

/*****************************************
 Enable shared VPC in the service project - explicitly depend on the host
 project enabling it, because enabling shared VPC will fail if the host project
 is not yet hosting.
*****************************************/

resource "google_compute_shared_vpc_service_project" "service_project_1" {
  host_project    = var.host_project_id
  service_project = var.service_project_id

  depends_on = [
    google_compute_shared_vpc_host_project.host_project,
    google_project_service.service_project,
  ]
}


/******************************************
  Default Service Account configuration
 *****************************************/

resource "google_service_account" "default_service_account" {
  account_id   = "project-service-account"
  display_name = "${var.service_project_id} Project Service Account"
  project      = var.service_project_id
}

/******************************************************************************************************************
  compute.networkUser role granted to APIs Service account, Project Service Account on shared VPC
 *****************************************************************************************************************/

resource "google_project_iam_member" "servcie_vpc_membership" {
  project = var.host_project_id
  role    = "roles/compute.networkUser"
  member  = local.api_ser_account_fmt

  depends_on = [
    google_compute_shared_vpc_service_project.service_project_1,
  ]
}
