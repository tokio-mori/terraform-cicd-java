output "s3_bucket_name" {
  description = "S3 bucket used for Terraform state."
  value = aws_s3_bucket.state.id
}

output "dynamodb_table_name" {
  description = "DynamoDB table used for Terraform state."
  value = aws_dynamodb_table.lock_table.id
}