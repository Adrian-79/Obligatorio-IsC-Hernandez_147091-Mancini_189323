##################################################################################
# Archivo: outputs.tf
# Descripción: Salidas importantes luego de aplicar Terraform para acceso y conexión
##################################################################################

##############################
# Networking (VPC/Subnets)
##############################

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "private_subnet_az1_id" {
  description = "ID de la subred privada en AZ1"
  value       = aws_subnet.private_az1.id
}

output "private_subnet_az2_id" {
  description = "ID de la subred privada en AZ2"
  value       = aws_subnet.private_az2.id
}

##############################
# Application Load Balancer
##############################

output "alb_dns_name" {
  description = "DNS del Application Load Balancer"
  value       = aws_lb.ecommerce_alb.dns_name
}

##############################
# Auto Scaling / EC2
##############################

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group de la aplicación"
  value       = aws_autoscaling_group.ecommerce_ec2_asg.name
}

output "ec2_security_group_id" {
  description = "ID del Security Group asociado a las instancias EC2"
  value       = aws_security_group.ecommerce_sg_ec2.id
}

##############################
# Base de Datos (RDS)
##############################

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = aws_db_instance.rds_ecommerce.address
}

output "rds_port" {
  description = "Puerto de conexión de la base de datos RDS"
  value       = aws_db_instance.rds_ecommerce.port
}

##############################
# EFS (File System Compartido)
##############################

output "efs_id" {
  description = "ID del sistema de archivos EFS"
  value       = aws_efs_file_system.ecommerce_efs.id
}

####################################
#arn launch_template
####################################
output "launch_template_id" {
  description = "ID del Launch Template para EC2"
  value       = aws_launch_template.ecommerce_lt.id
}