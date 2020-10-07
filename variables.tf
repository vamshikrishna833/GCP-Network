variable "credentials_file" {
  type = string
}

## Shared VPC

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

variable "region" {
  type = string
}

variable "enable_apis" {
  description = "Whether to actually enable the APIs. If false, this module is a no-op."
  default     = "true"
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

variable "shared_network_name" {
  default = "shared-network"
}

variable "shared_subnet_name" {
  default = "dev-shared-subnet"
}

variable "shared_subnet_cidr" {
  default = "172.20.11.0/24"
}

## VPC Peering

variable "vpc1_project_id" {
  description = "Enter the vpc1 project name"
}
variable "vpc1_network_name" {
  description = "Enter the vpc1 project network name"
}
variable "vpc2_project_id" {
  description = "Enter the vpc2ination project name"
}
variable "vpc2_network_name" {
  description = "Enter the vpc2ination project network name"
}

## Interconnect

variable "int_network_name" {
  description = "Name of the network"
}
variable "int_project_id" {
  description = "Project ID"
}
variable "int_router_name" {
  description = "Name of the router connected to interconnect"
}