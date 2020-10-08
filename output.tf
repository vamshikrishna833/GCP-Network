output "shared_network" {
  value = module.shared_vpc.private_network
}

output "shared_network" {
  value = module.shared_vpc_dev.private_network
}

output "shared_network" {
  value = module.shared_vpc_stag.private_network
}

output "shared_network" {
  value = module.shared_vpc_prod.private_network
}