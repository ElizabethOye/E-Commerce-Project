
resource "aws_security_group" "instance_sg" {
  name   = "instance_sg"
  vpc_id = aws_vpc.E-Commerce-Project.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "sg" {
  name   = "sg"
  vpc_id = aws_vpc.E-Commerce-Project.id

 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EKS Worker Node Security Group
resource "aws_security_group" "eks_sg" {
  name   = "eks-worker-sg"
  vpc_id = aws_vpc.E-Commerce-Project.id

  # Allow inbound traffic from RDS security group for database communication
  ingress {
    from_port   = 3306               
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.rds_sg.id] # Allow traffic from RDS SG
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name   = "rds-access-sg"
  vpc_id = aws_vpc.E-Commerce-Project.id

  # Allow inbound traffic from EKS worker nodes
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_sg.id] # Allow traffic from EKS SG
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

