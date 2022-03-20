# ------ ./modules/networking/outputs.tf ------


# output "vpc_private_subnets" {
#     # Result is a map of subent id to cidr block, e.g.
#     # { "subnet_1234" => "10.0.1.0/4"}
#     value = {
#         for subnet in aws_subnet.private : subnet.id => subnet.cidr_block
#     }
# }

output "vpc_id" {
  description = "The VPC Information"
  value = "${aws_vpc.vpc}"
}


output "internet-gw" {
  description = "The Internet gateway Information"
  value       = "${aws_internet_gateway.ig}"
}


output "nat_gateway" {
  description = "The NAT Gateway Information "
  value       = "${aws_nat_gateway.nat}"
}


output "eip" {
  description = "The EIP Information "
  value       = "${aws_eip.nat_eip}"
}


output "public_subnet" {
  description = "The Public Subnet Information "
  value       = "${aws_subnet.public_subnet}"
}


output "private_subnet" {
  description = "The Private Subnet Information "
  value       = "${aws_subnet.private_subnet}"
}


output "route_table_private" {
  description = "The Private Route Table Information "
  value       = "${aws_route_table.private}"
}


output "route_table_public" {
  description = "The Public Route Table Information "
  value       = "${aws_route_table.public}"
}
