
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.E-Commerce-Project.id
}