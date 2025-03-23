# TODO: refactor so this doesn't get copy/pasted
###############################################
## imports
################################################
data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.eks_cluster_id
}
## network
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["arc-poc-archit-nangla"]
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name = "tag:Name"
    values = [
      "arc-poc-archit-nangla-us-east-1b-2",
      "arc-poc-archit-nangla-us-east-1a-1"
    ]
  }
}

## security
data "aws_security_groups" "db_sg" {
  filter {
    name   = "group-name"
    values = ["${var.namespace}-${var.environment}-db-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_security_groups" "eks_sg" {
  filter {
    name   = "group-name"
    values = ["${var.namespace}-${var.environment}-eks-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_eks_cluster" "eks" {
  name = module.eks_cluster.eks_cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks_cluster.eks_cluster_id
}
