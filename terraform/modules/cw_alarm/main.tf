resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name                = "ec2-cpu-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 80
  insufficient_data_actions = []
  alarm_description         = "This metric monitors ec2 cpu utilization. 80% or more for 10m"
  alarm_actions = [var.alarm_sns_topic_arn]
  ok_actions = [var.alarm_sns_topic_arn]

  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}