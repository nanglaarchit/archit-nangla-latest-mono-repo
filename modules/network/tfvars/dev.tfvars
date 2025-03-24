name     = "my-network"
vpc_cidr = "10.0.0.0/16"
public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]
azs                            = ["us-east-1a", "us-east-1b"]
destination_cidr_block_public  = "0.0.0.0/0"
destination_cidr_block_private = "0.0.0.0/0"
