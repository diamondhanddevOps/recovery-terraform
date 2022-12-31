
# Create a list of subnets
resource "aws_subnet" "public_subnets" {
  count = 3
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = aws_vpc.webservervpc.id
  availability_zone = "us-east-1a" 
}
