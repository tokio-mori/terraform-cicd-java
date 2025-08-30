# EC2対応
resource "aws_security_group" "ec2_sg" {
  name = "${var.project_name}-${var.environment}-ec2-sg"
  description = "Security group for EC2"
  vpc_id = var.vpc_id

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.ssh_ingress_cidr_blocks
    description = "Allow SSH from specific IPs"
  }

  # HTTP/HTTPS(Web Server)
  ingress { 
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #ステベのIPからHTTPを許可
    description = "Allow HTTP from anywhere"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "${var.project_name}-${var.environment}-ec2-sg"
    environment = var.environment
  }
}

# RDS対応 (EC2からの接続のみ許可)
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for RDS instances"
  vpc_id      = var.vpc_id

  # EC2からのアクセスのみ許可
  ingress {
    from_port       = var.db_port # MySQL: 3306, PostgreSQL: 5432
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # EC2用SGからのアクセスのみ許可
    description     = "Allow DB access from EC2 instances"
  }

  # アウトバウンドルール: 全てのアウトバウンドを許可 (必要に応じて制限)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-sg"
    Environment = var.environment
  }
}