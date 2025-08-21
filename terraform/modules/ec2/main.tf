resource "aws_instance" "main" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = var.key_pair_name

  user_data = file("${path.module}/userdata.sh")

  # パブリックサブネットに配置する場合
  associate_public_ip_address = var.associate_public_ip

  tags = {
    name = "${var.project_name}-${var.environment}-ec2-instance"
    environment = var.environment
  }
}