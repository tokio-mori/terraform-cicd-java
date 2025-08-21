# DB Subnet Group (RDSは複数のAZにまたがるプライベートサブネットに配置)
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    name        = "${var.project_name}-${var.environment}-db-subnet-group"
    environment = var.environment
  }
}

resource "aws_db_instance" "main" {
  identifier           = "${var.project_name}-${var.environment}-db"
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  storage_type         = "gp2"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  port                 = var.db_port
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true # 本番環境ではfalseにすべき
  multi_az             = var.multi_az
  publicly_accessible  = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-db"
    Environment = var.environment
  }
}