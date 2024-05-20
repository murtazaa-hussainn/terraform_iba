# rds.tf

resource "aws_db_instance" "sp-private-mysql-database" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.35"  # Specify the MySQL version
  instance_class       = "db.t3.micro"  # Specify the database instance type
  username             = "root"
  password             = "rootpassword"  # Be sure to change this
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.sp-private-database-sg.id]  # Specify your VPC security group ID
  db_subnet_group_name = aws_db_subnet_group.sp-db-subnet-group.name
  skip_final_snapshot   = true
  publicly_accessible = false

  tags = {
    Name = "sp-private-mysql-database"
    Project = "DevOps Semester Project"
  }
}

resource "aws_db_subnet_group" "sp-db-subnet-group" {
  name       = "sp-db-subnet-group"
  subnet_ids = [aws_subnet.sp-subnet-private-1a.id, aws_subnet.sp-subnet-private-1b.id, aws_subnet.sp-subnet-private-1c.id]

  tags = {
    Name = "sp-db-subnet-group"
    Project = "DevOps Semester Project"
  }
}

output "sp-private-mysql-database-endpoint" {
  value = aws_db_instance.sp-private-mysql-database.endpoint
}

output "sp-private-mysql-database-username" {
  value = aws_db_instance.sp-private-mysql-database.username
}

output "sp-private-mysql-database-port" {
  value = aws_db_instance.sp-private-mysql-database.port
}
