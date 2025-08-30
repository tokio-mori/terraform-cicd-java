output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "rds_database_name" {
  value = module.rds.db_name
}

output "rds_username" {
  value = module.rds.rds_username
  sensitive = true
}