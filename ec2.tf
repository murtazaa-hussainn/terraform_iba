# ec2.tf

resource "aws_instance" "ubuntu_instance" {
  ami                    = "ami-036cafe742923b3d9" # Ubuntu 22.04 AMI ID
  instance_type          = "t2.micro"
  subnet_id              = "subnet-036cf26c3495daa01" # Hardcoded subnet ID for Ubuntu instance
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