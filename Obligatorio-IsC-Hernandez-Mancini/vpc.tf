##################################################################################
# Archivo: vpc.tf
# Descripción: Define la VPC personalizada para el entorno, con CIDR 10.0.0.0/16
##################################################################################

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ecommerce-vpc"
  }
}