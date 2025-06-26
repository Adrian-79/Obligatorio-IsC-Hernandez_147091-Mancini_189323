##################################################################################
# Archivo: main.tf
# Descripción: Entry point del proyecto, incluye proveedor, región y orquesta módulos
##################################################################################

#########################################
# Configuración del proveedor AWS
#########################################
provider "aws" {
  region = var.region # Región establecida en variables.tf (por defecto us-east-1)
}

#########################################
# Datos dinámicos del entorno AWS
#########################################
data "aws_region" "current" {} # Obtiene la región actual de forma automática (si se desea usar dinámicamente)

#########################################
# Definición de etiquetas comunes (tags)
#########################################
locals {
  common_tags = {
    Project     = "EcommerceInfra" # Nombre del proyecto
    Environment = "Production"     # Ambiente: Production, Dev, etc.
    Owner       = "Adrian"         # Propietario del entorno
  }
}

#########################################
# Configuración del bloque Terraform
#########################################
terraform {
  required_version = ">= 1.3.0" # Versión mínima de Terraform requerida

  required_providers {
    aws = {
      source  = "hashicorp/aws" # Proveedor oficial de AWS
      version = "~> 5.0"        # Versión compatible (>=5.0, <6.0)
    }
  }
}