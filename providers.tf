terraform {
  required_version = ">= 1.2.0" # Terraform required version

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.14.0"
    }
    docker = {
      source = "kreuzwerker/docker"

    }
  }
}

provider "aws" {
  # Configuration of: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION will happen in github action
  region = var.aws_region
  access_key = var.ACCESS_KEY_ID
  secret_key = var.SECRET_ACCESS_KEY
}

provider "docker" {}