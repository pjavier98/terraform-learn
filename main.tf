provider "aws" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.environment
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.environment
  }
}

# data "aws_vpc" "existing-vpc" {
#   default = true
# }

# resource "aws_subnet" "dev-subnet-2" {
#   vpc_id            = data.aws_vpc.existing-vpc.id
#   cidr_block        = "172.31.96.0/20"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "development-vpc-subnet-2"
#   }
# }

output "development-vpc-id" {
  value = aws_vpc.vpc.id
}

output "development-subnet-id" {
  value = aws_subnet.subnet-1.id
}
