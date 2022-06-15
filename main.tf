provider "aws" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.environment}-vpc"
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

module "app-webserver" {
  source = "./modules/webserver"

  vpc_id = aws_vpc.vpc.id

  subnet_id = module.app-subnet.subnet.id

  environment          = var.environment
  availability_zone    = var.availability_zone
  my_ip_address        = var.my_ip_address
  image_name           = var.image_name
  server_instance_type = var.server_instance_type
  public_key_location  = var.public_key_location
}
