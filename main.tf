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

resource "aws_internet_gateway" "learn-app-internet-gateway" {
  vpc_id = aws_vpc.learn-app-vpc.id

  tags = {
    Name = "${var.environment}-learn-app-internet-gateway"
  }
}

# resource "aws_route_table" "learn-app-route-table" {
#   vpc_id = aws_vpc.learn-app-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.learn-app-internet-gateway.id
#   }

#   tags = {
#     Name = "${var.environment}-learn-app-route-table"
#   }
# }

# resource "aws_route_table_association" "association-route-table-subnet" {
#   subnet_id      = aws_subnet.learn-app-subnet.id
#   route_table_id = aws_route_table.learn-app-route-table.id
# }

resource "aws_default_route_table" "learn-app-route-table" {
  default_route_table_id = aws_vpc.learn-app-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.learn-app-internet-gateway.id
  }

  tags = {
    Name = "${var.environment}-learn-app-route-table"
  }
}
