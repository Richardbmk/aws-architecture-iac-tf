# --- root/main.tf --- 

module "networking" {
  source = "./modules/networking/"

  # region = "${var.region}"
  environment        = var.environment
  subnate_group_name = var.subnate_group_name
  vpc_cidr                = var.vpc_cidr
  public_subnets_cidr     = var.public_subnets_cidr
  private_subnets_cidr    = var.private_subnets_cidr
  private_db_subnets_cidr = var.private_db_subnets_cidr
  availability_zones      = var.availability_zones
}
