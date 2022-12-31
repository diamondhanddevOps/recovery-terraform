resource "aws_autoscaling_attachment" "webserver" {
  autoscaling_group_name = aws_autoscaling_group.webserver6.name
  alb_target_group_arn   = aws_alb_target_group.webserver5.arn
}

resource "aws_cloudwatch_metric_alarm" "webserver1" {
  alarm_name          = "webserver-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  threshold           = "80"
  statistic           = "Average"
}

resource "aws_autoscaling_policy" "webserver2" {
  name                   = "webserver-scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.webserver6.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1

  policy_type = "StepScaling"
}
resource "aws_cloudwatch_metric_alarm" "webserver3" {
  alarm_name          = "webserver-cpu-utilization-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  threshold           = "80"
  statistic           = "Average"
}

resource "aws_autoscaling_policy" "webserver4" {
  name                   = "webserver-scale-in-policy"
  autoscaling_group_name = aws_autoscaling_group.webserver6.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  policy_type = "StepScaling"
  cooldown                = 300
 # metric_interval_lower_bound = 0
  
  
}

resource "aws_alb_target_group" "webserver5" {
  name = "webserver5"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.webservervpc.id

  health_check {
    path = "/health"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  
}

  # ... other target group properties
}

resource "aws_autoscaling_group" "webserver6" {
  launch_configuration = aws_launch_configuration.webserverlc.name
  min_size = 3
  max_size = 4
  availability_zones = ["us-east-1a","us-east-1b"]
  

  # ... other auto scaling group properties
  target_group_arns = [aws_alb_target_group.webserver5.arn]

}
# Create a scaling policy
resource "aws_autoscaling_policy" "my_scaling_policy" {
  name = "scale-up"
  autoscaling_group_name = aws_autoscaling_group.webserver6.name
  policy_type = "SimpleScaling"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
}
