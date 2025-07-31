variable "aws_region" {
  description = "The AWS REGION to deploy resources."
  type = string
  default = "us-west-2"
}

variable "s3_bucket_name" {
  description = "This S3 is Terraform state files."
  type = string
  default = "s3-tfstate-mori"
}

variable "dynamodb_table_name" {
  description = "This DynamoDB is Terraform state locking."
  type = string
  default = "dynamodb-tfstate-mori"
}