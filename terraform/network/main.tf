################################################################
## defaults
################################################################
terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region

  default_tags {
    tags = module.tags.tags
  }
}

module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

  environment = var.environment
  project     = "terraform-aws-ref-arch-network"

  extra_tags = {
    Example = "True"
  }
}

################################################################
## network
################################################################
module "network" {
  source  = "sourcefuse/arc-network/aws"
  version = "3.0.3"

  namespace   = var.namespace
  environment = var.environment

  name                    = var.network_name
  create_internet_gateway = true
  # Enable vpc_flow_logs:If `s3_bucket_arn` is null, CloudWatch logging is enabled by default. If provided, S3 logging is enabled
  vpc_flow_log_config = {
    enable            = var.vpc_flow_logs_enabled
    retention_in_days = var.vpc_flow_logs_retention
    s3_bucket_arn     = var.vpc_flow_logs_s3_bucket_arn
  }

  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  vpc_endpoint_data  = var.vpc_endpoint_data

  tags = module.tags.tags
}
