provider "aws" {
  region = var.aws_region
}

module "network" {
  source          = "../modules/network"
  name            = var.network_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "ec2_instance" {
  source              = "../modules/ec2"
  name                = var.ec2_name
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  subnet_id           = module.network.public_subnets[0]
  vpc_id              = module.network.vpc_id
  associate_public_ip = true

  sg_ingress  = var.sg_ingress
  ebs_volumes = var.ebs_volumes

  depends_on = [module.network]
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!@#%&*()-_=+[]{}<>?"
}

resource "aws_ssm_parameter" "rds_password" {
  name  = var.rds_password_ssm_name
  type  = "SecureString"
  value = random_password.rds_password.result
  tags  = { Name = var.ec2_name }
}

data "aws_ssm_parameter" "rds_password" {
  name            = var.rds_password_ssm_name
  with_decryption = true
  depends_on      = [aws_ssm_parameter.rds_password]
}

module "rds" {
  source              = "../modules/rds"
  name                = var.rds_name
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  db_name             = var.db_name
  username            = var.db_username
  password            = data.aws_ssm_parameter.rds_password.value
  port                = var.db_port
  multi_az            = var.multi_az
  subnet_ids          = module.network.private_subnets
  vpc_id              = module.network.vpc_id
  sg_ingress          = var.rds_sg_ingress
  skip_final_snapshot = var.skip_final_snapshot
  depends_on          = [module.network, module.ec2_instance]
}
