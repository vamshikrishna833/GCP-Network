variable "prefix" {
  description = "Name prefix for the network peerings"
  type        = string
  default     = "network-peering"
}

variable "local_network" {
  description = "Resource link of the network to add a peering to."
  type        = string
}

variable "peer_network" {
  description = "Resource link of the peer network."
  type        = string
}

variable "provider_local_network" {
  description = "GCP Provider for local VPC."
  type        = string
}

variable "provider_peer_network" {
  description = "GCP Provider for peer VPC."
  type        = string
}

variable "vpc1_project_id" {
  description = "Project ID of first VPC"
  type        = string
}

variable "vpc2_project_id" {
  description = "Project ID of second VPC"
  type        = string
}
