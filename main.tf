provider "aws" {}

resource "aws_vpc" "learn-app-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.environment}-learn-app-vpc"
  }
}

resource "aws_subnet" "learn-app-subnet" {
  vpc_id            = aws_vpc.learn-app-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.environment}-learn-app-subnet"
  }
}
