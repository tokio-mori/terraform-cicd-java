output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.main.id
}

output "private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.main.private_ip
}

output "public_ip" {
  description = "The public IP address of the EC2 instance (if associated)."
  value       = aws_instance.main.public_ip
}