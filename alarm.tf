resource "aws_cloudwatch_metric_alarm" "ALB_HTTP_requests_Alarm" {
  alarm_name          = "ALB_HTTP_requests_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTP_Redirect_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "1000"
  alarm_description   = "This metric monitors http requests forwarded from ALB to EC2"
}
