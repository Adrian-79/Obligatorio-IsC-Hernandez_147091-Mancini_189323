##################################################################################
# Archivo: nat_gateway.tf
# Descripción: Define NAT Gateway y Elastic IP para salida a Internet desde subredes privadas
##################################################################################

########################################################
# Sección: Elastic IP para NAT Gateway
########################################################
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

########################################################
# Sección: NAT Gateway
########################################################
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_az1.id

  tags = {
    Name = "ecommerce-natgw"
  }
}