##################################################################################
# Archivo: internet_gateway.tf
# Descripción: Define el Internet Gateway para la VPC
##################################################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-igw"
  }
}