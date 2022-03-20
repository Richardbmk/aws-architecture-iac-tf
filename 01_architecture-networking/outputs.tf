output "vpc_id" {
  description = "The VPC id"
  value       = module.networking.vpc_id
}


output "internet-gw" {
  description = "The Internet gateway ID "
  value       = module.networking.internet-gw
}



output "nat_gateway" {
  description = "The NAT Gateway Information "
  value       = module.networking.nat_gateway
}


output "eip" {
  description = "The EIP Information "
  value       = module.networking.eip
}


output "public_subnet" {
  description = "The Public Subnet Information "
  value       = module.networking.public_subnet
}


output "private_subnet" {
  description = "The Private Subnet Information "
  value       = module.networking.private_subnet
}


output "route_table_private" {
  description = "The Private Route Table Information "
  value       = module.networking.route_table_private
}


output "route_table_public" {
  description = "The Public Route Table Information "
  value       = module.networking.route_table_public
}
