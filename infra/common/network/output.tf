output "vpc_id" {
  value       = module.network.vpc_id
  description = "ID of the VPC"
}

output "igw_id" {
  value       = module.network.igw_id
  description = "Internet Gateway ID"
}

output "nat_gateway_ids" {
  value       = module.network.nat_gateway_ids
  description = "List of NAT Gateway IDs"
}


output "public_rt_id" {
  value       = module.network.public_rt_id
  description = "Public route table ID"
}

output "private_rt_id" {
  value       = module.network.privat_rt_id
  description = "Private route table ID"
}

###key pair##########

output "created_key_pair_name" {
  value = module.network.key_pair_name
}

output "generated_private_key_path" {
  value = module.network.private_key_path
}

output "subnet_ids" {
  value       = module.network.subnet_ids
  description = "Map of subnet names to subnet IDs"
}
