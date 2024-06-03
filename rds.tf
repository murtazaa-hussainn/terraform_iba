# rds.tf

resource "aws_db_instance" "sp-private-postgres-database" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.1"  # Specify the PostgreSQL version
  instance_class       = "db.t3.micro"  # Specify the database instance type
  username             = "root"
  password             = "rootpassword"  # Be sure to change this
  parameter_group_name = "default.postgres16"
  vpc_security_group_ids = [aws_security_group.sp-private-database-sg.id]  # Specify your VPC security group ID
  db_subnet_group_name = aws_db_subnet_group.sp-db-subnet-group.name
  skip_final_snapshot   = true
  publicly_accessible = false

  tags = {
    Name = "sp-private-postgres-database"
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

output "sp-private-postgres-database-endpoint" {
  value = aws_db_instance.sp-private-postgres-database.endpoint
}

output "sp-private-postgres-database-username" {
  value = aws_db_instance.sp-private-postgres-database.username
}

output "sp-private-postgres-database-port" {
  value = aws_db_instance.sp-private-postgres-database.port
}
