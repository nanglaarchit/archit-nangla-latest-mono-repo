################################################################################
## shared
################################################################################
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  default     = "poc"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "namespace" {
  type        = string
  default     = "arc"
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "engine_type" {
  type        = string
  default     = "cluster"
  description = "Type of database engine (e.g., cluster)"
}

variable "db_port" {
  type        = number
  default     = 5432
  description = "Database port"
}

variable "db_username" {
  type        = string
  default     = "postgres"
  description = "Username for the database"
}

variable "db_engine" {
  type        = string
  default     = "aurora-postgresql"
  description = "Database engine"
}

variable "db_engine_version" {
  type        = string
  default     = "16.2"
  description = "Database engine version"
}

variable "license_model" {
  type        = string
  default     = "postgresql-license"
  description = "License model for the database"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.medium"
  description = "Instance type for the RDS cluster"
}

variable "db_parameter_group_name" {
  type        = string
  default     = "default.aurora-postgresql16"
  description = "Parameter group for the database"
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Whether changes should be applied immediately"
}

variable "promotion_tier" {
  type        = number
  default     = 1
  description = "Promotion tier for RDS instances"
}

variable "create_subnet_group" {
  type        = bool
  default     = true
  description = "Whether to create a new subnet group"
}

variable "performance_insights_enabled" {
  type        = bool
  default     = true
  description = "Enable Performance Insights"
}

variable "kms_create" {
  type        = bool
  default     = true
  description = "Whether to create a new KMS key"
}

variable "kms_description" {
  type        = string
  default     = "KMS for Performance Insights and storage"
  description = "Description for the KMS key"
}

variable "kms_deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Number of days before KMS key deletion"
}

variable "kms_enable_key_rotation" {
  type        = bool
  default     = true
  description = "Enable key rotation for KMS"
}
