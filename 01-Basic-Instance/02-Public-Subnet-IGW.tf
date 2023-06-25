
############################################
#       Public Subnet GW-Route
############################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "Internet-GW"
  }
}


resource "aws_route_table" "igw_route" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "IGW-Route"
  }
}



resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.subnet-pub-1.id
  route_table_id = aws_route_table.igw_route.id
}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.subnet-pub-2.id
  route_table_id = aws_route_table.igw_route.id
}


############################################
