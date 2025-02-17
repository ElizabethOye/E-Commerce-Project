#Provision Internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.E-Commerce-Project.id
}

#Provision Nat gateway
resource "aws_nat_gateway" "E-Commerce-Project" {
  allocation_id = aws_eip.ec.id
  subnet_id     = aws_subnet.private.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW]
}


#Provision Route table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.E-Commerce-Project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Route to internet"
  }
}
#Route table association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route.id
}