variable "host_project_id" {
  description = "Project ID for host project to host the shared VPC."
  default     = ""
  type        = string
}
variable "region" {
  description = "Pass the Region value for the network."
  default     = ""
  type        = string
}
variable "shared_network" {
  description = "Required to provide Network Name."
  default     = ""
  type        = string  
}
variable "shared_subnet_name" {
  description = "Required to provide Subnet Name."
  default     = ""
  type        = string    
}
variable "shared_subnet_cidr" {
  description = "Required to provide Subnet CIDR."
  default     = ""
  type        = string  
}
