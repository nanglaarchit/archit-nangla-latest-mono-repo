# network
data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["arc-poc-archit-nangla"]
  }
}

data "aws_subnets" "private" {
  filter {
    name = "tag:Name"

    ## try the created subnets from the upstream network module, or override with custom names
    values = length(var.subnet_names) > 0 ? var.subnet_names : [
      "arc-poc-archit-nangla-us-east-1b-2",
      "arc-poc-archit-nangla-us-east-1a-1"
    ]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
