variable "project_name" {
  description = "Project name tag."
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to create Securit group."
  type        = string
}

variable "db_port" {
  description = "The port for the database."
  type        = number
}

variable "ssh_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allow SSH access."
  type        = list(string)
  default     = ["0.0.0.0/0"] # 本番環境では特定のIP
}