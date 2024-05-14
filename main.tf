# main.tf

provider "aws" {
  region = "us-west-1"
}

#variable "vpc_id" {
#  description = "The ID of the VPC in which to create resources"
#  default     = "vpc-040fc261" # Replace with your VPC ID
#}

#module "ec2" {
#  source = "./ec2"
#}
