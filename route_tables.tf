resource "aws_internet_gateway" "semester_project_ig" {
  vpc_id = aws_vpc.semester_project_vpc.id

  tags = {
    Name = "semester_project_ig"
  }
}

resource "aws_eip" "semester_project_eip" {
  tags = {
    Name = "semester_project_eip"
  }
}

resource "aws_nat_gateway" "semester_project_nat_gw" {
  allocation_id = aws_eip.semester_project_eip.id
  subnet_id     = aws_subnet.semester_project_public_1a.id

  tags = {
    Name = "semester_project_nat_gw"
  }
}

resource "aws_route_table" "semester_project_public_rtb" {
  vpc_id = aws_vpc.semester_project_vpc.id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.semester_project_ig.id
  }

  tags = {
    Name = "semester_project_public_rtb"
  }
}

resource "aws_route_table" "semester_project_private_rtb" {
  vpc_id = aws_vpc.semester_project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.semester_project_nat_gw.id
  }

  tags = {
    Name = "semester_project_private_rtb"
  }
}

resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = aws_subnet.semester_project_public_1a.id  # This should be your private subnet
  route_table_id = aws_route_table.semester_project_public_rtb.id
}

resource "aws_route_table_association" "public_subnet_1b_association" {
  subnet_id      = aws_subnet.semester_project_public_1b.id  # This should be your private subnet
  route_table_id = aws_route_table.semester_project_public_rtb.id
}

resource "aws_route_table_association" "public_subnet_1c_association" {
  subnet_id      = aws_subnet.semester_project_public_1c.id  # This should be your private subnet
  route_table_id = aws_route_table.semester_project_public_rtb.id
}

resource "aws_route_table_association" "private_subnet_1a_association" {
  subnet_id      = aws_subnet.semester_project_private_1a.id  # This should be your private subnet
  route_table_id = aws_route_table.semester_project_private_rtb.id
}

resource "aws_route_table_association" "private_subnet_1b_association" {
  subnet_id      = aws_subnet.semester_project_private_1b.id  # This should be your private subnet
  route_table_id = aws_route_table.semester_project_private_rtb.id
}

resource "aws_route_table_association" "private_subnet_1c_association" {
  subnet_id      = aws_subnet.semester_project_private_1c.id  # This should be your private subnet
  route_table_id = aws_route_table.semester_project_private_rtb.id
}
