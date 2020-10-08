output "shared_network" {
  value = module.shared_vpc.private_network
}

output "shared_network_dev" {
  value = module.shared_vpc_dev.private_network
}

output "shared_network_stag" {
  value = module.shared_vpc_stag.private_network
}

output "shared_network_prod" {
  value = module.shared_vpc_prod.private_network
}