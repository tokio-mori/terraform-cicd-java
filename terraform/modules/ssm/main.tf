resource "aws_ssm_parameter" "cw_agent_config" {
  name = var.parameter_name
  type = "String"
  value = var.config_json_content

  tags = {
    name = var.parameter_name
  }
}