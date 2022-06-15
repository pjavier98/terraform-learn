resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.environment}-subnet"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}

resource "aws_default_route_table" "route-table" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "${var.environment}-route-table"
  }
}
