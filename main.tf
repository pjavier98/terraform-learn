provider "aws" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.environment}-learn-app-vpc"
  }
}

module "app-subnet" {
  source = "./modules/subnet"

  vpc_id                 = aws_vpc.vpc.id
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  environment       = var.environment
  availability_zone = var.availability_zone
  subnet_cidr_block = var.subnet_cidr_block
}

resource "aws_default_security_group" "security-group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_address]
  }

  ingress {
    description = "Browser from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.environment}-security-group"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.lastest-amazon-linux-image.id
  instance_type = var.server_instance_type

  subnet_id              = aws_subnet.learn-app-subnet.id
  vpc_security_group_ids = [aws_default_security_group.security-group.id]
  availability_zone      = var.availability_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name = "${var.environment}-webserver"
  }
}
