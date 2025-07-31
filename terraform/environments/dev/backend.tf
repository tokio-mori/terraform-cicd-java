terraform {
 backend "s3" {
   bucket = "s3-tfstate-mori"
   key = "environments/dev/terraform.tfstate"
   region = "us-west-2"
   dynamodb_table = "dynamodb-tfstate-mori"
   encrypt = true
 } 
}