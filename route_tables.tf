# Defining Route Tables and their Related Components

# Defining Internet Gateway
resource "aws_internet_gateway" "sp-internet-gateway" {
  vpc_id = aws_vpc.sp-vpc.id

  tags = {
    Name = "semester_project_ig"
  }
}

# Defining Elastic IP
resource "aws_eip" "sp-elastic-ip" {
  tags = {
    Name = "semester_project_eip"
  }
}

# Defining NAT Gateway and Allocating Elastic IP
resource "aws_nat_gateway" "sp-nat-gateway" {
  allocation_id = aws_eip.sp-elastic-ip.id
  subnet_id     = aws_subnet.sp-subnet-public-1a.id

  tags = {
    Name = "semester_project_nat_gw"
  }
}

# Defining Public Route Table
resource "aws_route_table" "sp-route-table-public" {
  vpc_id = aws_vpc.sp-vpc.id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.sp-internet-gateway.id
  }

  tags = {
    Name = "semester_project_public_rtb"
  }
}

# Defining Private Route Table
resource "aws_route_table" "sp-route-table-private" {
  vpc_id = aws_vpc.sp-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sp-nat-gateway.id
  }

  tags = {
    Name = "semester_project_private_rtb"
  }
}

# Defining Public Subnet Associations with Route Table
resource "aws_route_table_association" "sp-subnet-public-1a-association" {
  subnet_id      = aws_subnet.sp-subnet-public-1a.id
  route_table_id = aws_route_table.sp-route-table-public.id
}

resource "aws_route_table_association" "sp-subnet-public-1b-association" {
  subnet_id      = aws_subnet.sp-subnet-public-1b.id
  route_table_id = aws_route_table.sp-route-table-public.id
}

resource "aws_route_table_association" "sp-subnet-public-1c-association" {
  subnet_id      = aws_subnet.sp-subnet-public-1c.id
  route_table_id = aws_route_table.sp-route-table-public.id
}

# Defining Private Subnet Associations with Route Table
resource "aws_route_table_association" "sp-subnet-private-1a-association" {
  subnet_id      = aws_subnet.sp-subnet-private-1a.id
  route_table_id = aws_route_table.sp-route-table-private.id
}

resource "aws_route_table_association" "sp-subnet-private-1b-association" {
  subnet_id      = aws_subnet.sp-subnet-private-1b.id
  route_table_id = aws_route_table.sp-route-table-private.id
}

resource "aws_route_table_association" "sp-subnet-private-1c-association" {
  subnet_id      = aws_subnet.sp-subnet-private-1c.id
  route_table_id = aws_route_table.sp-route-table-private.id
}
