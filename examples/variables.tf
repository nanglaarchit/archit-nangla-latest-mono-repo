variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "destination_cidr_block_public" {
  description = "CIDR block for public route table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "destination_cidr_block_private" {
  description = "CIDR block for private route table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ec2_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "sg_ingress" {
  description = "Security group ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ebs_volumes" {
  description = "EBS volume configurations"
  type        = list(map(string))
}

variable "rds_name" {
  description = "Name of the RDS instance"
  type        = string
}

variable "rds_password_ssm_name" {
  description = "SSM Parameter Store name for RDS password"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for RDS"
  type        = number
}

variable "storage_type" {
  description = "Storage type for RDS"
  type        = string
}

variable "engine" {
  description = "Database engine for RDS"
  type        = string
}

variable "engine_version" {
  description = "Engine version for RDS"
  type        = string
}

variable "instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "db_name" {
  description = "Database name for RDS"
  type        = string
}

variable "db_username" {
  description = "Database username for RDS"
  type        = string
}

variable "db_port" {
  description = "Port number for RDS"
  type        = number
}

variable "multi_az" {
  description = "Enable multi-AZ deployment"
  type        = bool
}

variable "rds_sg_ingress" {
  description = "Security group ingress rules for RDS"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot before deleting the RDS instance"
  type        = bool
  default     = true
}
