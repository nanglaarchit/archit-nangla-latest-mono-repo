output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}
