resource "aws_vpc" "webservervpc" {
  cidr_block = "172.32.0.0/16"
}
resource "aws_vpc" "webservervpc1" {
  cidr_block = "172.32.0.0/16"
}
resource "aws_vpc_peering_connection" "webservervpering" {
  peer_vpc_id = aws_vpc.webservervpc1.id
  vpc_id      = aws_vpc.webservervpc.id
  auto_accept = true
}

resource "aws_route_table" "webserver-rt" {
  vpc_id = aws_vpc.webservervpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "webserver-igw"
  }

  route {
    cidr_block      = "10.0.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.webservervpering.id
  }
}

