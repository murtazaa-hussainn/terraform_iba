# main.tf

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "semester_project_vpc" {
  cidr_block = "192.168.0.0/16"  # CIDR block for the VPC

  tags = {
    Name = "semester_project_vpc"
  }
}

#module "ec2" {
#  source = "./ec2"
#}
