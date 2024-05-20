# Create EC2 Instances for Application

# Create Ubuntu Public Bastion Server
resource "aws_instance" "sp-public-ubuntu-bastion" {
  ami                         = "ami-04b70fa74e45c3917" # Ubuntu 24.04 AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sp-subnet-public-1a.id # Hardcoded subnet ID for Ubuntu instance
  key_name                    = "sp-key-pair"
  vpc_security_group_ids      = [aws_security_group.sp-public-bastion-sg.id] # Assign Ubuntu security group
  # security_groups             = [aws_security_group.semester_project_public_sg.id] # Assign Ubuntu security group
  associate_public_ip_address = true
  iam_instance_profile        = "bastion-role"
  tags = {
    Name = "sp-public-ubuntu-bastion"
    Project = "DevOps Semester Project"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/bastion_userdata.sh", {})
}

# Create Ubuntu Private Frontend Server
resource "aws_instance" "sp-private-ubuntu-frontend" {
  ami                         = "ami-04b70fa74e45c3917" # Ubuntu 22.04 AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sp-subnet-private-1a.id # Hardcoded subnet ID for Ubuntu instance
  key_name                    = "sp-key-pair"
  vpc_security_group_ids      = [aws_security_group.sp-private-frontend-sg.id] 
  # security_groups             = [aws_security_group.semester_project_private_sg.id] # Same as above but not created through UI
  associate_public_ip_address = false
  tags = {
    Name = "sp-private-ubuntu-frontend"
    Project = "DevOps Semester Project"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/frontend_userdata.sh", {
    backend-ip = aws_instance.sp-private-ubuntu-backend.private_ip
  })
}

# Create Ubuntu Private Backend Server
resource "aws_instance" "sp-private-ubuntu-backend" {
  ami                         = "ami-04b70fa74e45c3917" # Ubuntu 22.04 AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sp-subnet-private-1a.id # Hardcoded subnet ID for Ubuntu instance
  key_name                    = "sp-key-pair"
  vpc_security_group_ids      = [aws_security_group.sp-private-backend-sg.id] 
  # security_groups             = [aws_security_group.semester_project_private_sg.id] # Same as above but not created through UI
  associate_public_ip_address = false
  tags = {
    Name = "sp-private-ubuntu-backend"
    Project = "DevOps Semester Project"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/backend_userdata.sh", {
    db-username = aws_db_instance.sp-private-mysql-database.username
    db-password = aws_db_instance.sp-private-mysql-database.password
    db-endpoint = aws_db_instance.sp-private-mysql-database.endpoint
  })
}

output "sp-public-ip-bastion" {
  value = aws_instance.sp-public-ubuntu-bastion.public_ip
}

output "sp-private-ip-frontend" {
  value = aws_instance.sp-private-ubuntu-frontend.private_ip
}

output "sp-private-ip-backend" {
  value = aws_instance.sp-private-ubuntu-backend.private_ip
}