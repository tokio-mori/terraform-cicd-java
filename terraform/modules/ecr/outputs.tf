output "repository_url" {
  description = "URL of ECR repository"
  value = aws_ecr_repository.app.repository_url
}

output "repository_name" {
  description = "Name of ECR repository"
  value = aws_ecr_repository.app.name
}