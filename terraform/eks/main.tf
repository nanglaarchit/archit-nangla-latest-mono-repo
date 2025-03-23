############################################################################
## default
############################################################################
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.24.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}


module "tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.2"
  environment = var.environment
  project     = "arc"

  extra_tags = {
    Repo = "github.com/sourcefuse/terraform-aws-arc-eks"
  }
}

module "eks_cluster" {
  source                    = "sourcefuse/arc-eks/aws"
  version                   = "5.0.5"
  environment               = var.environment
  name                      = var.name
  namespace                 = var.namespace
  desired_size              = var.desired_size
  instance_types            = var.instance_types
  kubernetes_namespace      = var.kubernetes_namespace
  create_node_group         = true
  max_size                  = var.max_size
  min_size                  = var.min_size
  subnet_ids                = data.aws_subnets.private.ids
  region                    = var.region
  vpc_id                    = data.aws_vpc.vpc.id
  enabled                   = true
  kubernetes_version        = var.kubernetes_version
  apply_config_map_aws_auth = false
  kube_data_auth_enabled    = false
  kube_exec_auth_enabled    = false
  #  csi_driver_enabled        = var.csi_driver_enabled
  # local_exec_interpreter               = var.local_exec_interpreter
  map_additional_iam_roles = var.map_additional_iam_roles
  allowed_security_groups  = concat(data.aws_security_groups.eks_sg.ids, data.aws_security_groups.db_sg.ids)
}
