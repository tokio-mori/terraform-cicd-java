# プロジェクト固有の環境変数を定義
variable "project_name" {
  description = "A unique name for the project."
  type        = string
  default     = "my-web-app"
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
  default     = "us-west-2"
}

variable "availability_zones" {
  description = "List of Availability Zones to use."
  type        = list(string)
  default     = ["us-west-2a", "us-west-2c"] # 2つのAZを使用
}

# RDSのパスワードは環境変数などで渡すか、Terraform Vaultなどと連携することを強く推奨
variable "rds_password" {
  description = "Password for the RDS database."
  type        = string
  sensitive   = true
}