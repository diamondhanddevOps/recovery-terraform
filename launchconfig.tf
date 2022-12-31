resource "aws_launch_configuration" "webserverlc" {
  image_id      = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  user_data = <<EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    systemctl start apache2
    systemctl enable apache2
   apt-get -y install awscli
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_autoscaling_group" "webserver-asg" {
#   name                = "webserver-asg"
#   launch_configuration = aws_launch_configuration.webserver.name
#   min_size            = 2
#   max_size            = 4
#   desired_capacity    = 2
#   vpc_zone_identifier = [aws_subnet.webservervpc.*.id]

#   tag {
#     key                 = "Name"
#     value               = "webserver"
#     propagate_at_launch = true
#   }
# }

# resource "aws_launch_configuration" "webserverlc" {
#   # ... other launch configuration properties

#   associate_public_ip_address = true
#   image_id                   = "ami-0ceecbb0f30a902a6"
#   instance_type              = "t2.micro"
#   security_groups            = [aws_security_group.webserversg.id]
#   user_data                  = base64encode(file("user-data.sh"))
# }

# resource "aws_auto_scaling_group" "webserver-asg" {
#   name                      = "webserver-asg"
#   launch_configuration      = aws_launch_configuration.webserver.name
#   min_size                  = 1
#   max_size                  = 3
#   vpc_zone_identifier       = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
#   target_group_arns         = [aws_alb_target_group.webserver.arn]
# }

#resource "aws_launch_configuration" "webserverlc" {
  # ... other launch configuration properties

 # user_data = <<EOF
#!/bin/bash

# Update the package manager and install the Apache web server
#apt-get update
#apt-get -y install apache2

# Start the Apache web server and enable it to start on boot
#systemctl start apache2
#systemctl enable apache2
#apt-get -y install awscli
#EOF
#}

#resource "aws_launch_configuration" "webserverlc" {
  # ... other launch configuration properties

# user_data = << EOF 
#!/bin/bash

# Update the package manager and install the Apache web server and the AWS CLI

# Download the index.html file from the S3 bucket
# aws s3 cp s3://my-bucket/index.html /var/www/html/index.html

#  Set the correct permissions on the index.html file
# chmod 644 /var/www/html/index.html

#  Start the Apache web server and enable it to start on boot
# systemctl start apache2
# systemctl enable apache2
# EOF
#}