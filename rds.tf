# rds.tf

# resource "aws_db_instance" "mysql_instance" {
#   allocated_storage    = 5
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "8.0.35"  # Specify the MySQL version
#   instance_class       = "db.t3.micro"  # Specify the database instance type
#   username             = "murtaza"
#   password             = "murtazapassword"  # Be sure to change this
#   parameter_group_name = "default.mysql8.0"
#   vpc_security_group_ids = [aws_security_group.mysql_sg.id]  # Specify your VPC security group ID
#   skip_final_snapshot   = true
#   publicly_accessible = true

#   tags = {
#     Name = "Murtaza MySQL Instance"
#   }
# }

# resource "aws_db_instance" "postgres_instance" {
#   allocated_storage    = 5
#   storage_type         = "gp2"
#   engine               = "postgres"
#   engine_version       = "16.1"  # Specify the PostgreSQL version
#   instance_class       = "db.t3.micro"  # Specify the database instance type
#   username             = "murtaza"
#   password             = "murtazapassword"  # Be sure to change this
#   parameter_group_name = "default.postgres16"
#   vpc_security_group_ids = [aws_security_group.psql_sg.id]  # Specify your VPC security group ID
#   skip_final_snapshot   = true
#   publicly_accessible = true

#   tags = {
#     Name = "Murtaza PostgreSQL Instance"
#   }
# }

# output "mysql_instance_endpoint" {
#   value = aws_db_instance.mysql_instance.endpoint
# }

# output "mysql_instance_username" {
#   value = aws_db_instance.mysql_instance.username
# }

# output "psql_instance_endpoint" {
#   value = aws_db_instance.postgres_instance.endpoint
# }

# output "psql_instance_username" {
#   value = aws_db_instance.postgres_instance.username
# }
