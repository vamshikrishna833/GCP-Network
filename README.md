## Shared VPC Infrastructure Automation

This module will create a shared VPC to enable connectivity to shared resources.

 This module creates the following infrastructure:
- A Shared VPC connection between the service project and Host project.

### Predefine project mandatory requirement:

We assume that the following setup is already exist in GCP to run this module.

- A Project under an Organisation (`we need this project to run the terraform`)
- A Service Account which is linked with above project (`we need service account key to run this module`)
- A service account key which is associated with the above service account.

The Predefine project should have following APIs enabled before running this module.

- Service Networking API (`servicenetworking.googleapis.com`)

Service account permission at project level.

- `roles/owner` it manage the resources under project
- `roles/compute.networkAdmin` it manage the shared network
- `roles/resourcemanager.projectIamAdmin` it manage the permission at project level
- `roles/servicenetworking.networksAdmin` it manage the network service between the projects
- `roles/iam.serviceAccountAdmin` it manage the service accounts under project

Service account permission at organization level.

- `roles/compute.xpnAdmin` it shared the network between the projects
- `roles/compute.networkAdmin` it manage the shared network
- `roles/iam.serviceAccountAdmin` it manage the service accounts


### Software

We can run this module from anywhere only when the following dependencies must be available:

- [Terraform v0.12](https://www.terraform.io/downloads.html)
- [gcloud sdk](https://cloud.google.com/sdk/install)
- Service Account key which we have created in above steps. By default, name of the file is credentials.json. If you change the name then you can update in terraform.tfvars mentioned below.

## Usage

Steps to run this module:

- Change the directory 'cd GCP-Network/'
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply -auto-approve` to apply the infrastructure build with auto approve
- `terraform destroy` to destroy the built infrastructure

To Initialise and apply:
- `terraform init && terraform apply -auto-approve` to initialise and apply with auto approve in one go

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| host\_project\_id | To be Host project ID | string | `"true"` | yes |
| service\_project\_id | To be Service Project ID | string | `"true"` | yes |
| service\_project\_number | To be Service Project ID | string | `"true"` | yes |
| region | The region to set subnet in | string | `"us-east1"` | no |
| shared\_vpc-network\_name | The name of the network within which the Shared VPC Subnets reside | string | shared-network | no |
| shared\_vpc-subnets | The list of subnetworks within the shared VPC to attach this project to, e.g. 'projects/PROJECT_ID/regions/us-east1/subnetworks/default' | list(string) | `<list>` | no |

## API's for Host Project
This module will activate these APIs in Host project so that we can create the resources under this project:

- Service Networking API (`servicenetworking.googleapis.com`)

## API's for Service Project
This module will activate these APIs in Service project so that we can create the resources under this project:

- Service Networking API (`servicenetworking.googleapis.com`)
- Cloud Service Usage API (`serviceusage.googleapis.com`)

## Example Usage

```
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
```