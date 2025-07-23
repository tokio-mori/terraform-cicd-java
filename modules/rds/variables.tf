variable "project_name" {
  description = "Project name tag."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prd)."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group to attach to the RDS instance."
  type        = string
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgres)."
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine."
  type        = string
}

variable "db_instance_class" {
  description = "The instance type for the RDS instance."
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB for the DB instance."
  type        = number
}

variable "db_name" {
  description = "The database name."
  type        = string
}

variable "db_username" {
  description = "The master username for the database."
  type        = string
}

variable "db_password" {
  description = "The master password for the database."
  type        = string
  sensitive   = true # パスワードは機密情報として扱う
}

variable "db_port" {
  description = "The port for the database (e.g., 3306 for MySQL, 5432 for PostgreSQL)."
  type        = number
}

variable "multi_az" {
  description = "Specifies if the DB instance is Multi-AZ."
  type        = bool
  default     = false # 開発環境ではfalse, 本番環境ではtrueを推奨
}