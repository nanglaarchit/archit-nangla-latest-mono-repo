################################################
## imports
################################################
## vpc
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["arc-poc-archit-nangla"] # Correct VPC name
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name = "tag:Name"
    values = [
      "arc-poc-archit-nangla-us-east-1a-1",
      "arc-poc-archit-nangla-us-east-1b-2"
    ]
  }
}
