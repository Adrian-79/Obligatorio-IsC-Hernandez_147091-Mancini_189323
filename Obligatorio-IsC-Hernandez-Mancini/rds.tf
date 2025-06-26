##################################################################################
# Archivo: rds.tf
# Descripción: Define la base de datos RDS MySQL con Multi-AZ para alta disponibilidad
# Se distribuye en subredes privadas AZ1 y AZ2
##################################################################################

#####################################
# Grupo de Subredes para RDS
#####################################

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]

  tags = {
    Name = "rds-subnet-group"
  }
}

######################################
# Instancia RDS MySQL
######################################

resource "aws_db_instance" "rds_ecommerce" {
  identifier             = "rds-ecommerce"
  allocated_storage      = var.rds_allocated_storage
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.rds_instance_class
  username               = var.rds_username
  password               = var.rds_password
  db_name                = var.rds_db_name
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name #despliegue RDS subneet priv1 y priv2
  vpc_security_group_ids = [aws_security_group.ecommerce_sg_rds.id]
  multi_az               = true
  skip_final_snapshot    = true
  publicly_accessible    = false
  apply_immediately      = true

  tags = {
    Name = "rds-ecommerce"
  }
}