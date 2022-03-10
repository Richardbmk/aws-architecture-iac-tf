# --- root/main.tf --- 

# # Deploy Networking Resources
# module "vpc" {
#     source = "./modules/networking/"

#     infra_env = var.infra_env
# }

module "networking" {
  source = "./modules/networking/"

  region = "${var.region}"
  environment = "${var.environment}"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnets_cidr = "${var.public_subnets_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
  availability_zones   = "${var.availability_zones}"
}
