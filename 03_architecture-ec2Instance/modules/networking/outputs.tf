# ------ ./modules/networking/outputs.tf ------

output "vpc_id" {
  description = "The VPC Information"
  value = "${aws_vpc.vpc.id}"
}


output "internet-gw" {
  description = "The Internet gateway Information"
  value       = "${aws_internet_gateway.ig.id}"
}


output "nat_gateway" {
  description = "The NAT Gateway Information "
  value       = "${aws_nat_gateway.nat.*.public_ip}"
}


output "eip" {
  description = "The EIP Information "
  value       = "${aws_eip.nat_eip.*.public_ip}"
}


output "public_subnet" {
  description = "The Public Subnet Information "
  value       = "${aws_subnet.public_subnet.*.id}"
}


output "private_subnet" {
  description = "The Private Subnet Information "
  value       = "${aws_subnet.private_subnet.*.id}"
}


output "route_table_private" {
  description = "The Private Route Table Information "
  value       = "${aws_route_table.private.*.id}"
}


output "route_table_public" {
  description = "The Public Route Table Information "
  value       = "${aws_route_table.public.*.id}"
}


output "aws_db_subnet_group" {
  description = "The Subnet Group Information "
  value       = "${aws_db_subnet_group.mysubnetgroup.subnet_ids}"
}
