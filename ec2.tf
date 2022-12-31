resource "aws_instance" "webserver" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  
  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      user = "ec2-user"
      
      
      private_key = file("abi")
      
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
    ]
  }
}

# resource "aws_ami" "webserver" {
#   name                = "webserver-golden-ami"
#   ami        = "ami-0b5eea76982371e91"
#   virtualization_type = "hvm"

#   ena_support         = true

#   tags = {
#     Name = "webserver-golden-ami"
#   }
# }

# resource "aws_ami_copy" "webserver" {
#   name                = "webserver-golden-ami-copy"
#   description         = "Copy of webserver Golden AMI in us-west-1 region"
#   source_ami_id       = aws_ami.webserver.id
#   source_ami_region   = "us-east-1"
#   # destination_region  = "us-west-1"
#   encrypted           = true
#   kms_key_id          = "arn:aws:kms:us-west-1:123456789012:key/abcdefgh-1234-5678-9012-abcdefghijkl"
#   tags = {
#     Name = "webserver-golden-ami-copy"
#   }
# }
