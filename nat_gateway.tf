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