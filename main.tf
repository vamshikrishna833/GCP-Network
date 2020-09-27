provider "google" {
  region      = var.region
  credentials = var.credentials_file
  version     = "~> 3.3.0"
}
provider "google-beta" {
  region      = var.region
  credentials = var.credentials_file
  version     = "~> 3.3.0"
}

module "shared_vpc" {
  source = "./modules/shared-vpc/"

  host_project_id        = var.host_project_id
  service_project_id     = var.service_project_id
  service_project_number = var.service_project_number

  activate_apis_host    = var.activate_apis_host
  activate_apis_service = var.activate_apis_service

  shared_network_name = var.shared_network_name
  shared_subnet_name  = var.shared_subnet_name
  shared_subnet_cidr  = var.shared_subnet_cidr

}

