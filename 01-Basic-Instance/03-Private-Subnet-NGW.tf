############################################
#       Private Subnet GW-Route
############################################

resource "aws_eip" "nat_eip" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet-pub-1.id

  tags = {
    Name = "Private-Nat-GW"
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-Route"
  }
}



#
#       Access to internet from private subnet
#
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.subnet-priv-1.id
  route_table_id = aws_route_table.private_route.id
}
#
#       Access to internet from private subnet
#
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.subnet-priv-2.id
  route_table_id = aws_route_table.private_route.id
}

#######################################################
