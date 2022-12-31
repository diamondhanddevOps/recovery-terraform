# # Create an SSL certificate in ACM
# resource "aws_acm_certificate" "example" {
#   domain_name       = "example.com"
#   validation_method = "DNS"

#   tags = {
#     Name = "example-certificate"
#   }
# }

# # Create the Application Load Balancer
# resource "aws_alb" "example" {
#   name            = "example-alb"
#   internal        = false
#   security_groups = [aws_security_group.alb.id]
#   subnets         = [for s in aws_subnet.alb.*.id: s]

#   # Listen on port 443 and use the SSL certificate
#   https_listener {
#     port     = "443"
#     protocol = "HTTPS"
#     certificate_arn = aws_acm_certificate.example.arn
#   }

#   # Add other listeners and backend resources as needed...
# }

# # Create security group for the ALB
# resource "aws_security_group" "alb" {
#   name        = "example-alb-sg"
#   description = "Security group for the example ALB"
#   vpc_id      = aws_vpc.main.id

#   # Allow incoming HTTPS traffic
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Add other rules as needed...
# }

# # Create subnets for the ALB
# resource "aws_subnet" "alb" {
#   count             = 2
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
#   availability_zone = data.aws_availability_zone.available.names[count.index]
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "example-alb-subnet-${count.index + 1}"
#   }
# }
