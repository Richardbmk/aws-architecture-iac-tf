# ------ ./modules/networking/main.tf ------

# # Create a VPC for the region associated with the AZ
# resource "aws_vpc" "vpc" {
#     cidr_block = var.vpc_cidr

#     tags = {
#         Name = "rickdev-${var.infra_env}-vpc"
#         Porject = "rickdev-learning"
#         Environment = var.infra_env
#         ManagedBy = "terraform"
#     }
# }

# # Create 1 public subnets for each AZ within the regional VPC
# resource "aws_subnet" "public" {
#     for_each = var.public_subnet_numbers

#     vpc_id = aws_vpc.vpc.id
#     availability_zone =  each.key

#     cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

#     tags = {
#         Name = "rickdev-${var.infra_env}-public-subnet"
#         Porject = "rickdev-learning"
#         Role = "public"
#         Environment = var.infra_env
#         ManagedBy = "terraform"
#         Subnet = "${each.key}-${each.value}"
#     }
# }

# # Create 1 private subnets for each AZ within the regional VPC
# resource "aws_subnet" "private" {
#     for_each = var.private_subnet_numbers

#     vpc_id = aws_vpc.vpc.id
#     availability_zone =  each.key

#     cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

#     tags = {
#         Name = "rickdev-${var.infra_env}-public-subnet"
#         Porject = "rickdev-learning"
#         Role = "private"
#         Environment = var.infra_env
#         ManagedBy = "terraform"
#         Subnet = "${each.key}-${each.value}"
#     }
# }

# Description of the VPC
resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "${var.environment}-vpc"
        Environment = "${var.environment}"
    }
}

# Subnets Definitions
# Internet Gateway for the public subnet
resource "aws_internet_gateway" "ig" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags = {
        Name = "${var.environment}-igw"
        Environment = "${var.environment}"
    }
}

# Elastic IP fon NAT
resource "aws_eip" "nat_eip" {
    vpc = true
    depends_on = [aws_internet_gateway.ig]
}

# NAT
resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.nat_eip.id}"
    subnet_id = "${element(aws_subnet.public_subnet.*.id, 0)}"
    depends_on = [aws_internet_gateway.ig]

    tags = {
        Name = "nat"
        Environment = "${var.environment}"
    }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.vpc.id}"
    count = "${length(var.public_subnets_cidr)}"
    cidr_block = "${element(var.public_subnets_cidr, count.index)}"
    availability_zone = "${element(var.availability_zones, count.index)}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
        Environment = "${var.environment}"
    }
}

# Private subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = "${aws_vpc.vpc.id}"
    count = "${length(var.private_subnets_cidr)}"
    cidr_block = "${element(var.private_subnets_cidr, count.index)}"
    availability_zone = "${element(var.availability_zones, count.index)}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
        Environment = "${var.environment}"
    }
}

# Routing table for private subnet
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags = {
        Name = "${var.environment}-private-route-table"
        Environment = "${var.environment}"
    }
}

# Routing table for public subnet
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags = {
        Name = "${var.environment}-public-route-table"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "public_internet_gateway" {
    route_table_id = "${aws_route_table.public.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
}

resource "aws_route" "private_nat_gateway" {
    route_table_id = "${aws_route_table.private.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

# Route table associations
resource "aws_route_table_association" "public" {
    count = "${length(var.public_subnets_cidr)}"
    subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
    count = "${length(var.private_subnets_cidr)}"
    subnet_id = "${element(aws_subnet.private_subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}
