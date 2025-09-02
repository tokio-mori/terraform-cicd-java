variable "alarm_sns_topic_arn" {
  description = "The ARN of the SNS topic to send alarm"
  type = string
}

variable "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  type = string
}