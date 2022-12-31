# resource "aws_acm_certificate" "webserver" {
#   domain_name       = "diamondhanddevops.com"
#   validation_method = "DNS"

#   tags = {
#     Name = "webserver-certificate"
#   }
# }

# resource "aws_lb_listener_certificate" "webserver" {
#   listener_arn = aws_lb_listener.webserver.arn
#   certificate_arn = aws_acm_certificate.webserver.arn
# }

# resource "aws_alb" "webserver-alb" {
#   # ... other ALB properties
# }

# resource "aws_acm_certificate" "webserveracm" {
#   # ... other ACM certificate properties
# }

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_alb.example.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
#   certificate_arn   = aws_acm_certificate.example.arn

#   default_action {
#     # ... other listener action properties
#   }
# }
