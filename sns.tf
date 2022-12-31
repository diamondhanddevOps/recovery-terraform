resource "aws_sns_topic" "webserver" {
  name = "webserver-sns-topic"
}

resource "aws_autoscaling_notification" "webserver" {
  group_names = [aws_autoscaling_group.webserver6.name]
  topic_arn       = aws_sns_topic.webserver.arn
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
}
