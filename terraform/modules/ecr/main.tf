resource "aws_ecr_repository" "app" {
  name = var.repository_name
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    name = var.repository_name
    environment = var.environment
  }

  force_delete = true
}