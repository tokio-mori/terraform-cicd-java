output "topic_arn" {
  description = "ARN of the SNS topic"
  value = aws_sns_topic.app_alerts.arn
}