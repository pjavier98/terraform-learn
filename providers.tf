terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "terraform-learn-app"
    key    = "terraform-learn-app/state.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.1"
    }
  }
}
