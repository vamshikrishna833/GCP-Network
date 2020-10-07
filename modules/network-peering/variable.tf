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