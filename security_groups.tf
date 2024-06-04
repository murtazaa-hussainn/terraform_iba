resource "aws_security_group" "sp-public-bastion-sg" {
  vpc_id      = aws_vpc.sp-vpc.id
  name        = "sp-public-bastion-sg"
  description = "Allows SSH access to developers"

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sp-private-frontend-sg" {
  vpc_id      = aws_vpc.sp-vpc.id
  name        = "sp-private-frontend-sg"
  description = "Allows SSH access to developers"
  
  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sp-private-backend-sg" {
  vpc_id      = aws_vpc.sp-vpc.id
  name        = "sp-private-backend-sg"
  description = "Allows SSH access to developers"
  
  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sp-private-database-sg" {
  vpc_id      = aws_vpc.sp-vpc.id
  name        = "sp-private-database-sg"
  description = "Security Group for PostgreSQL Instance"
  
  # Ingress rules
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
