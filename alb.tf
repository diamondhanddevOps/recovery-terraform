
resource "aws_alb" "webserver" {
  name            = "webserver-alb"
  internal        = false
  security_groups = [aws_security_group.webserversg.id]
  subnets         = [for subnet in aws_subnet.public_subnets: subnet.id]
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.webserver.arn
  port              = "80"
  protocol          = "HTTP"
 #ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  # certificate_arn   = var.certificate_arn
  default_action{

  
     target_group_arn = aws_alb_target_group.webserver-alb.arn
      type             = "forward"
   }
 

}
resource "aws_alb_target_group" "webserver-alb" {
  name = "webserver-alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.webservervpc.id
  health_check {
    path = "/health"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener_rule" "webserverls" {
  listener_arn = aws_alb_listener.http.arn
  priority = 100

  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.webserver-alb.arn
  }
 condition {
    host_header {
      values = ["diamondhanddevops.com"]
    }
  }
  # condition {
  #   field = "path-pattern"
  #   values = ["/"]
  # }
}
