variable "credentials_file" {
  type = string
}

variable "region" {
  default = "us-east1"
}

#Shared VPC

variable "host_project_id" {
  description = "Project ID for host project to host the shared VPC"
  type        = string
}
variable "service_project_id" {
  description = "Project ID for service project"
  type        = string
}
variable "service_project_number" {
  description = "Required to provide service account in service project network usuer role."
  type        = string
}

variable "enable_apis" {
  description = "Whether to actually enable the APIs. If false, this module is a no-op."
  default = "true"
}

variable "activate_apis_service" {
  description = "The list of apis to activate within the project"
  type        = list(string)
  default = [
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}

variable "activate_apis_host" {
  description = "The list of apis to activate within the project"
  type        = list(string)
  default = [
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}

#Network VPC

variable "shared_network_name" {
  default = "shared-network"
}

variable "shared_subnet_name" {
  default = "us-east1-shared-subnet"
}

variable "shared_subnet_cidr" {
  default = "10.0.0.0/16"
}

#Development VPC

variable "host_project_id_dev" {
  description = "Project ID for host project to host the shared VPC"
  type        = string
}
variable "service_project_id_dev" {
  description = "Project ID for service project"
  type        = string
}
variable "service_project_number_dev" {
  description = "Required to provide service account in service project network usuer role."
  type        = string
}

variable "shared_network_name_dev" {
  default = "shared-network-dev"
}

variable "shared_subnet_name_dev" {
  default = "us-east1-shared-subnet-dev"
}

variable "shared_subnet_cidr_dev" {
  default = "10.1.0.0/16"
}

#Staging VPC

variable "host_project_id_stag" {
  description = "Project ID for host project to host the shared VPC"
  type        = string
}
variable "service_project_id_stag" {
  description = "Project ID for service project"
  type        = string
}
variable "service_project_number_stag" {
  description = "Required to provide service account in service project network usuer role."
  type        = string
}

variable "shared_network_name_stag" {
  default = "shared-network-stag"
}

variable "shared_subnet_name_stag" {
  default = "us-east1-shared-subnet"
}

variable "shared_subnet_cidr_stag" {
  default = "10.2.0.0/16"
}

#Production VPC

variable "host_project_id_prod" {
  description = "Project ID for host project to host the shared VPC"
  type        = string
}
variable "service_project_id_prod" {
  description = "Project ID for service project"
  type        = string
}
variable "service_project_number_prod" {
  description = "Required to provide service account in service project network usuer role."
  type        = string
}

variable "shared_network_name_prod" {
  default = "shared-network-prod"
}

variable "shared_subnet_name_prod" {
  default = "us-east1-shared-subnet"
}

variable "shared_subnet_cidr_prod" {
  default = "10.3.0.0/16"
}

#Interconnect

variable "asn_bgp" {
  default = ""
}
