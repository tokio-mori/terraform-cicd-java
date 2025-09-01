resource "aws_instance" "main" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = var.key_pair_name

  user_data = templatefile("${path.module}/userdata.sh", {
    ssm_param_name = var.cw_agent_config_ssm_parameter_name
  })

  # パブリックサブネットに配置する場合
  associate_public_ip_address = var.associate_public_ip

  iam_instance_profile = var.iam_instance_profile_name

  tags = {
    name = "${var.project_name}-${var.environment}-ec2-instance"
    environment = var.environment
  }
}

resource "aws_eip" "app_server_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.main.id
  allocation_id = aws_eip.app_server_eip.id
}