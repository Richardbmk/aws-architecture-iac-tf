# --- root/variables.tf ---

variable "aws_region" {
  default = "us-west-2"
}

# variable "infra_env" {
#   default = "rickrock"
# }

variable "region" {}
variable "vpc_cidr" {}
variable "environment" {}
variable "public_subnets_cidr" {}
variable "private_subnets_cidr" {}
variable "availability_zones" {}
