resource "aws_security_group" "security-group" {
  vpc_id = var.vpc_id
  name   = "security-group"

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

data "aws_ami" "lastest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.lastest-amazon-linux-image.id
  instance_type = var.server_instance_type

  subnet_id              = var.subnet_id
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [aws_security_group.security-group.id]

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name = "${var.environment}-webserver"
  }
}
