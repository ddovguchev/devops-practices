module "vpc_creator" {
  source                      = "./modules/vpc"
  vpc_cidr_block              = local.vpc_cidr_block
  enable_dns_hostnames        = true
  enable_dns_support          = true
  public_subnets_cidr_blocks  = local.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = local.private_subnets_cidr_blocks
  create_igw                  = true
  aws_availability_zones      = data.aws_availability_zones.available.names
}

module "ec2_creator" {
  source         = "./modules/ec2"
  vpc_id         = module.vpc_creator.vpc.id
  servers_config = local.servers_config
  depends_on     = [module.vpc_creator]
}

#module "rds_creator" {
#  source              = "./modules/rds"
#  vpc_id              = module.vpc_creator.vpc.id
#  allocated_storage   = 20
#  storage_type        = "gp2"
#  instance_class      = "db.t3.micro"
#  port                = 5432
#  username            = var.db_user
#  password            = var.db_pass
#  subnet_ids          = [module.vpc_creator.private_subnets.rds1.id, module.vpc_creator.private_subnets.rds2.id]
#  allowed_cidr_blocks = [module.vpc_creator.private_subnets.nginx_host.cidr]
#  workspace           = terraform.workspace
#}
