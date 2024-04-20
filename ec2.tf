# ec2.tf

resource "aws_instance" "ubuntu_instance" {
  ami                    = "ami-08e4b984abde34a4f" # Ubuntu 20.04 AMI ID
  instance_type          = "t2.micro"
  subnet_id              = "subnet-a1a969d6" # Hardcoded subnet ID for Ubuntu instance
  key_name               = "tf_test"
  security_groups        = [aws_security_group.ubuntu_sg.id] # Assign Ubuntu security group
  tags = {
    Name = "tf_created_ec2_ubuntu"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/ubuntu_userdata.sh", {})
}

resource "aws_instance" "amazon_linux_2_instance" {
  ami                    = "ami-04f73ca9a4310089f" # Amazon Linux 2 AMI ID
  instance_type          = "t2.micro"
  subnet_id              = "subnet-3e5c0878" # Hardcoded subnet ID for Amazon Linux 2 instance
  key_name               = "tf_test"
  security_groups        = [aws_security_group.amazon_linux_sg.id] # Assign Amazon Linux 2 security group
  tags = {
    Name = "tf_created_ec2_amazon_linux_2"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/al2_userdata.sh", {})
}

resource "aws_instance" "amazon_linux_2023_instance" {
  ami                    = "ami-0dc44e17251b74325" # Amazon Linux 2023 AMI ID
  instance_type          = "t2.micro"
  subnet_id              = "subnet-c742efa2" # Hardcoded subnet ID for Amazon Linux 2023 instance
  key_name               = "tf_test"
  security_groups        = [aws_security_group.amazon_linux_sg.id] # Assign Amazon Linux 2023 security group
  tags = {
    Name = "tf_created_ec2_amazon_linux_2023"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/al2023_userdata.sh", {})
}
