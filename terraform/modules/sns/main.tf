resource "aws_sns_topic" "app_alerts" {
  name = "app-alerts-topic"
}

resource "aws_sns_topic_subscription" "name" {
  topic_arn = aws_sns_topic.app_alerts.arn
  protocol = "email"
  endpoint = var.notification_email
}