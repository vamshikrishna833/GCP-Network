variable "host_project_id" {
  default = ""
}

variable "service_project_id" {
  default = ""
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
  default     = []
}

variable "activate_apis_host" {
  description = "The list of apis to activate within the project"
  type        = list(string)
  default     = []
}

variable "disable_services_on_destroy" {
  description = "Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy"
  default     = "true"
  type        = string
}

variable "disable_dependent_services" {
  description = "Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_dependent_services"
  default     = "true"
  type        = string
}

variable "shared_network_name" {
  default = ""
}

variable "shared_subnet_name" {
  default = ""
}

variable "shared_subnet_cidr" {
  default = ""
}
