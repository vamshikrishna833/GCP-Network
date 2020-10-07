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

module "vpc-peering" {
  source            = "./modules/vpc-peering/"
  vpc1_project_id   = var.vpc1_project_id
  vpc1_network_name = var.vpc1_network_name
  vpc2_project_id   = var.vpc2_project_id
  vpc2_network_name = var.vpc2_network_name
}

#module "gcp-interconnect-vlan" {
#  source       = "./modules/gcp-interconnect/"
#  network_name = var.int_network_name
#  project_id   = var.int_project_id
#  router_name  = var.int_router_name
#}