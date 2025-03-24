################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "aurora" {
  source  = "sourcefuse/arc-db/aws"
  version = "4.0.0"

  environment = var.environment
  namespace   = var.namespace
  vpc_id      = data.aws_vpc.vpc.id

  name           = "${var.namespace}-${var.environment}-test"
  engine_type    = var.engine_type
  port           = var.db_port
  username       = var.db_username
  engine         = var.db_engine
  engine_version = var.db_engine_version

  license_model = var.license_model
  rds_cluster_instances = [
    {
      instance_class          = var.instance_class
      db_parameter_group_name = var.db_parameter_group_name
      apply_immediately       = var.apply_immediately
      promotion_tier          = var.promotion_tier
    }
  ]

  db_subnet_group_data = {
    name        = "${var.namespace}-${var.environment}-subnet-group"
    create      = var.create_subnet_group
    description = "Subnet group for rds instance"
    subnet_ids  = data.aws_subnets.private.ids
  }

  performance_insights_enabled = var.performance_insights_enabled

  kms_data = {
    create                  = var.kms_create
    description             = var.kms_description
    deletion_window_in_days = var.kms_deletion_window_in_days
    enable_key_rotation     = var.kms_enable_key_rotation
  }
}
