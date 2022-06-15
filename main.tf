provider "aws" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs            = [var.availability_zone]
  public_subnets = [var.subnet_cidr_block]

  public_subnet_tags = {
    Name = "${var.environment}-subnet"
  }

  tags = {
    Name = "${var.environment}-vpc"
  }
}

module "app-webserver" {
  source = "./modules/webserver"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]

  environment          = var.environment
  availability_zone    = var.availability_zone
  my_ip_address        = var.my_ip_address
  image_name           = var.image_name
  server_instance_type = var.server_instance_type
  public_key_location  = var.public_key_location
}
