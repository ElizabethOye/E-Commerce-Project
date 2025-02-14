provider "aws" {
  region = var.aws_region
}

data "aws_ssm_parameter" "instance_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_vpc" "E-Commerce-Project" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "E-Commerce-Project"
  }
}

resource "aws_eip" "ec" {
  domain   = "vpc"
}

resource "aws_subnet" "public" {
  
  vpc_id                  = aws_vpc.E-Commerce-Project.id
  cidr_block              = var.public_subnet_cidr[0]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "E-Commerce-Project_public"
  }
}

resource "aws_subnet" "private" {
 
  vpc_id            = aws_vpc.E-Commerce-Project.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "E-Commerce-Project_private"
  }
}



data "aws_availability_zones" "available" {}
