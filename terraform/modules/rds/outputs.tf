output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = aws_db_instance.main.address
}

output "db_instance_port" {
  description = "The port of the RDS instance."
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "The name of the RDS instance"
  value = aws_db_instance.main.db_name
}

output "rds_username" {
  value = aws_db_instance.main.username
}