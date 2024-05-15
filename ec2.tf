# ec2.tf

resource "aws_instance" "semester_project_bastion_server" {
  ami                         = "ami-04b70fa74e45c3917" # Ubuntu 24.04 AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.semester_project_public_1a.id # Hardcoded subnet ID for Ubuntu instance
  key_name                    = "semester_project_kp"
  vpc_security_group_ids      = [aws_security_group.semester_project_public_sg.id] # Assign Ubuntu security group
  # security_groups             = [aws_security_group.semester_project_public_sg.id] # Assign Ubuntu security group
  associate_public_ip_address = true
  iam_instance_profile        = "murtaza-bastion-role"
  tags = {
    Name = "semester_project_bastion_server"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

}

resource "aws_instance" "semester_project_frontend_ec2" {
  ami                         = "ami-04b70fa74e45c3917" # Ubuntu 22.04 AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.semester_project_private_1a.id # Hardcoded subnet ID for Ubuntu instance
  key_name                    = "semester_project_kp"
  vpc_security_group_ids      = [aws_security_group.semester_project_private_sg.id] 
  # security_groups             = [aws_security_group.semester_project_private_sg.id] # Same as above but not created through UI
  associate_public_ip_address = false
  tags = {
    Name = "semester_project_frontend_ec2"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

}

output "bastion_server_public_ip" {
  value = aws_instance.semester_project_bastion_server.public_ip
}

output "frontend_server_private_ip" {
  value = aws_instance.semester_project_frontend_ec2.private_ip
}