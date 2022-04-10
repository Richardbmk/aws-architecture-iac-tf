# --- root/main.tf --- 


# VPC Module configuration
module "networking" {
  source = "./modules/networking/"

  environment             = var.environment
  subnate_group_name      = var.subnate_group_name
  vpc_cidr                = var.vpc_cidr
  public_subnets_cidr     = var.public_subnets_cidr
  private_subnets_cidr    = var.private_subnets_cidr
  private_db_subnets_cidr = var.private_db_subnets_cidr
  availability_zones      = var.availability_zones
}

# SG Module Configuration
### Private SG
module "security-group" {
  source = "./modules/security-groups/"

  access_ip   = var.access_ip
  vpc_id      = module.networking.vpc_id
  multiple_security_groups = local.multiple_security_groups
}
