output "vpc_id" {
  value       = module.network.vpc_id
  description = "VPC ID of the created network"
}

output "public_subnets" {
  value       = module.network.public_subnets
  description = "List of public subnets"
}

output "private_subnets" {
  value       = module.network.private_subnets
  description = "List of private subnets"
}

output "rds_instance_id" {
  value       = module.rds.rds_instance_id
  description = "RDS instance ID"
}

output "rds_security_group_id" {
  value       = module.rds.rds_security_group_id
  description = "RDS security group ID"
}
