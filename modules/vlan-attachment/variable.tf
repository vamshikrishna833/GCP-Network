variable "prefix" {
  description = "Name prefix for the vlan attachment"
  type        = string
  default     = "on-prem-attachment"
}

variable "vlan_interconnect_type" {
  description = "Vlan Attachment Type."
  type        = string
}

variable "vpc_network" {
  description = "VPN Network Name."
  type        = string
}

variable "project_id" {
  description = "Project id."
  type        = string
}

variable "asn" {
  description = "BGP ASN number."
  type        = string
}