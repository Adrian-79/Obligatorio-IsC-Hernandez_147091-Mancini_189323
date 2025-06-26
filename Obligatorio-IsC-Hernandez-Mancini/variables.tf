##################################################################################
# Archivo: variables.tf
# Descripción: Variables usadas en el proyecto, organizadas por módulo y servicio
##################################################################################
#########################################
# MÓDULO: REDES
# Servicios: VPC, Subredes, Internet Gateway, NAT Gateway
#########################################
# Configuración Regional
variable "region" {
  description = "Región AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

# Configuración de Red
variable "vpc_cidr" {
  description = "CIDR block para la VPC principal"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_az1_cidr" {
  description = "CIDR para subred pública en AZ1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_az2_cidr" {
  description = "CIDR para subred pública en AZ2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_az1_cidr" {
  description = "CIDR para subred privada en AZ1"
  type        = string
  default     = "10.0.11.0/24"
}

variable "private_subnet_az2_cidr" {
  description = "CIDR para subred privada en AZ2"
  type        = string
  default     = "10.0.12.0/24"
}

#########################################
# MÓDULO: COMPUTOS
# Servicios: EC2, Launch Template, Auto Scaling Group
#########################################
# Configuración EC2
variable "ami_id" {
  description = "AMI ID para instancias EC2 (Amazon Linux 2)"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nombre del key pair SSH"
  type        = string
}

# Configuración Auto Scaling
variable "asg_min_size" {
  description = "Número mínimo de instancias en el ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Número máximo de instancias en el ASG"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Capacidad deseada de instancias en el ASG"
  type        = number
  default     = 2
}

#########################################
# MÓDULO: DATABASE
# Servicio: RDS (MySQL)
#########################################
# Configuración RDS
variable "rds_instance_class" {
  description = "Clase de instancia para RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Almacenamiento asignado a RDS (GB)"
  type        = number
  default     = 20
}

variable "rds_username" {
  description = "Usuario maestro para RDS"
  type        = string
  sensitive   = true
}

variable "rds_password" {
  description = "Contraseña para RDS"
  type        = string
  sensitive   = true
}

variable "rds_db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "ecommerce"
}

variable "db_endpoint" {
  description = "Endpoint externo o personalizado de la base de datos"
  type        = string
}

#########################################
# MÓDULO: SECURITY
# Servicio: Security Groups
#########################################
# Configuración de Seguridad
variable "admin_cidr" {
  description = "CIDR para acceso administrativo (SSH)"
  type        = string
}

#########################################
# MÓDULO: APPLICATION
# Servicio: App Web en EC2 (PHP + GitHub)
#########################################
# Configuración de la Aplicación
variable "github_repo" {
  description = "URL del repositorio Git con el código de la aplicación"
  type        = string
  default     = "github_repo"
}







