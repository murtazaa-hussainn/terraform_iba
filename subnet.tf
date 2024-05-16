# Defining Subnets and their CIDR Blocks

# Public Subnets
resource "aws_subnet" "sp-subnet-public-1a" {
  vpc_id            = aws_vpc.sp-vpc.id
  cidr_block        = "192.168.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sp-subnet-public-1a"
  }
}

resource "aws_subnet" "sp-subnet-public-1b" {
  vpc_id            = aws_vpc.sp-vpc.id
  cidr_block        = "192.168.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "sp-subnet-public-1b"
  }
}

resource "aws_subnet" "sp-subnet-public-1c" {
  vpc_id            = aws_vpc.sp-vpc.id
  cidr_block        = "192.168.13.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "sp-subnet-public-1c"
  }
}

# Private Subnets
resource "aws_subnet" "sp-subnet-private-1a" {
  vpc_id            = aws_vpc.sp-vpc.id
  cidr_block        = "192.168.21.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sp-subnet-private-1a"
  }
}

resource "aws_subnet" "sp-subnet-private-1b" {
  vpc_id            = aws_vpc.sp-vpc.id
  cidr_block        = "192.168.22.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "sp-subnet-private-1b"
  }
}

resource "aws_subnet" "sp-subnet-private-1c" {
  vpc_id            = aws_vpc.sp-vpc.id
  cidr_block        = "192.168.23.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "sp-subnet-private-1c"
  }
}