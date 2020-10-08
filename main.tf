provider "google" {
  region      = var.region
  credentials = var.credentials_file
  version     = "~> 3.42.0"
}
provider "google-beta" {
  region      = var.region
  credentials = var.credentials_file
  version     = "~> 3.42.0"
}

module "shared_vpc" {
  source = "./modules/shared-vpc/"
  enable_apis = true

  host_project_id        = var.host_project_id
  service_project_id     = var.service_project_id
  service_project_number = var.service_project_number

  activate_apis_host    = var.activate_apis_host
  activate_apis_service = var.activate_apis_service

  shared_network_name = var.shared_network_name
  shared_subnet_name  = var.shared_subnet_name
  shared_subnet_cidr  = var.shared_subnet_cidr

}

module "shared_vpc_dev" {
  source = "./modules/shared-vpc/"
  enable_apis = false

  host_project_id        = var.service_project_id # Shared VPC uses host_project_id for VPC creation hence revered it in Module
  service_project_id     = var.host_project_id
  service_project_number = var.service_project_number

  shared_network_name = var.shared_network_name_dev
  shared_subnet_name  = var.shared_subnet_name_dev
  shared_subnet_cidr  = var.shared_subnet_cidr_dev
}

module "shared_vpc_stag" {
  source = "./modules/shared-vpc/"
  enable_apis = false

  host_project_id        = var.service_project_id # Shared VPC uses host_project_id for VPC creation hence revered it in Module
  service_project_id     = var.host_project_id
  service_project_number = var.service_project_number

  shared_network_name = var.shared_network_name_stag
  shared_subnet_name  = var.shared_subnet_name_stag
  shared_subnet_cidr  = var.shared_subnet_cidr_stag
}

module "shared_vpc_prod" {
  source = "./modules/shared-vpc/"
  enable_apis = false

  host_project_id        = var.service_project_id # Shared VPC uses host_project_id for VPC creation hence revered it in Module
  service_project_id     = var.host_project_id
  service_project_number = var.service_project_number

  shared_network_name = var.shared_network_name_prod
  shared_subnet_name  = var.shared_subnet_name_prod
  shared_subnet_cidr  = var.shared_subnet_cidr_prod
}

module "network_peering_dev" {
  source = "./modules/network-peering/"

  provider_local_network = module.shared_vpc.private_network_name
  provider_peer_network  = module.shared_vpc_dev.private_network_name
  local_network          = module.shared_vpc.private_network        
  peer_network           = module.shared_vpc_dev.private_network
  vpc1_project_id =    module.shared_vpc.host_project_id
  vpc2_project_id =    module.shared_vpc_dev.host_project_id

}

module "network_peering_stag" {
  source = "./modules/network-peering/"

  provider_local_network = module.shared_vpc.private_network_name
  provider_peer_network  = module.shared_vpc_stag.private_network_name
  local_network          = module.shared_vpc.private_network         
  peer_network           = module.shared_vpc_stag.private_network   
  vpc1_project_id =    module.shared_vpc.host_project_id
  vpc2_project_id =    module.shared_vpc_stag.host_project_id 

}

module "network_peering_prod" {
  source = "./modules/network-peering/"

  provider_local_network = module.shared_vpc.private_network_name
  provider_peer_network  = module.shared_vpc_prod.private_network_name
  local_network          = module.shared_vpc.private_network         
  peer_network           = module.shared_vpc_prod.private_network
  vpc1_project_id =    module.shared_vpc.host_project_id
  vpc2_project_id =    module.shared_vpc_prod.host_project_id    

}


module "onprem_vlan_attachment" {
  source = "./modules/vlan-attachment/"
  vlan_interconnect_type = "PARTNER"
  asn                    = var.asn_bgp
  vpc_network            = module.shared_vpc.private_network_name
  project_id =  module.shared_vpc.host_project_id
 
}