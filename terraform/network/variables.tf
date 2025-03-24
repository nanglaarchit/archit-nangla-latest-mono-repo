################################################################
## shared
################################################################
variable "environment" {
  type        = string
  description = "Name of the environment, i.e. dev, stage, prod"
  default     = "poc"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "namespace" {
  type        = string
  description = "Namespace of the project, i.e. refarch"
  default     = "arc"
}

variable "network_name" {
  type        = string
  description = "Name of the network"
  default     = "arc-poc-archit-nangla"
}

# variable "create_internet_gateway" {
#   type        = bool
#   default     = true
#   description = "Flag to create an Internet Gateway"
# }

variable "vpc_flow_logs_enabled" {
  type        = bool
  default     = false
  description = "Enable VPC Flow Logs"
}

variable "vpc_flow_logs_retention" {
  type        = number
  default     = 7
  description = "Retention period for VPC Flow Logs (in days)"
}

variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  default     = ""
  description = "S3 bucket ARN for VPC Flow Logs (if applicable)"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "List of availability zones"
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "vpc_endpoint_data" {
  type = list(object({
    service            = string
    route_table_filter = string
  }))
  default = [
    { service = "s3", route_table_filter = "private" },
    { service = "dynamodb", route_table_filter = "private" }
  ]
  description = "VPC endpoints configuration"
}
