# アカウント制御の場合はIAMロール制御が別途必要

# S3(tfstate格納)
resource "aws_s3_bucket" "state" {
  bucket = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "state_ver" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_config" {
  bucket = aws_s3_bucket.state.id
  rule {
      apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
      }
  }
}

# DynamoDB(ロック管理)
resource "aws_dynamodb_table" "lock_table" {
  name = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    name = "StateLockTable"
    Environment = "Backend"
  }
}