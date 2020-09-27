variable "credentials_file" {
  type = string
}
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
  default = "us-east1"
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
  default = "us-east1-shared-subnet"
}

variable "shared_subnet_cidr" {
  default = "172.20.11.0/24"
}


