resource "aws_subnet" "semester_project_public_1a" {
  vpc_id            = aws_vpc.semester_project_vpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "semester_project_public_1a"
  }
}

resource "aws_subnet" "semester_project_public_1b" {
  vpc_id            = aws_vpc.semester_project_vpc.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "semester_project_public_1b"
  }
}

resource "aws_subnet" "semester_project_public_1c" {
  vpc_id            = aws_vpc.semester_project_vpc.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "semester_project_public_1c"
  }
}

resource "aws_subnet" "semester_project_private_1a" {
  vpc_id            = aws_vpc.semester_project_vpc.id
  cidr_block        = "192.168.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "semester_project_private_1a"
  }
}

resource "aws_subnet" "semester_project_private_1b" {
  vpc_id            = aws_vpc.semester_project_vpc.id
  cidr_block        = "192.168.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "semester_project_private_1b"
  }
}

resource "aws_subnet" "semester_project_private_1c" {
  vpc_id            = aws_vpc.semester_project_vpc.id
  cidr_block        = "192.168.6.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "semester_project_private_1c"
  }
}