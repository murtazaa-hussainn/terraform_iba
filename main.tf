# main.tf

# Defining the provider and region
provider "aws" {
  region = "us-east-1"
}

# Defining the VPC
resource "aws_vpc" "sp-vpc" {
  cidr_block = "192.168.0.0/16"  # CIDR block for the VPC

  tags = {
    Name = "sp-vpc"
    Project = "DevOps Semester Project"
  }
}