module "compute" {
  source = "./modules/compute"
  public_subnet_id = module.network.public_subnet_id
  vpc_id = module.network.vpc_id
}

module "network" {
  source = "./modules/network"  
  cidr_block = var.cidr_block
}

