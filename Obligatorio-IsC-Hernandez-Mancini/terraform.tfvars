##################################################################################
# Archivo: terraform.tfvars
# Descripción: Valores asignados a las variables para facilitar el despliegue
##################################################################################
#########################################
# AMI y Clave SSH
#########################################
ami_id   = "ami-0dc3a08bd93f84a35" # AMI de Amazon Linux 2 (válida en us-east-1)
key_name = "vockey"                # Nombre del par de claves SSH creado en AWS

#########################################
# Seguridad: Acceso administrativo (SSH)
#########################################
admin_cidr = "167.61.173.10/32" # IP pública del administrador para SSH

#########################################
# Configuración de RDS (Base de datos)
#########################################
rds_username = "admin"                                                   # Usuario administrador
rds_password = "admin1234"                                               # Contraseña
rds_db_name  = "ecommerce"                                               # Nombre de la base
db_endpoint  = "db-obligatorio.cfanplfpi7x9.us-east-1.rds.amazonaws.com" # Endpoint RDS

#########################################
# Código de la Aplicación
#########################################
github_repo = "https://github.com/Adrian-79/Obligatorio-IsC-Hernandez_147091-Mancini_189323.git" # Repositorio con el código PHP

#########################################
# Instancia EC2 (tipo de máquina)
#########################################
instance_type = "t3.micro"

