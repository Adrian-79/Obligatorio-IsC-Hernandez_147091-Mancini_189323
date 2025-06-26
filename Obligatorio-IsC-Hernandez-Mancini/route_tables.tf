##################################################################################
# Archivo: route_tables.tf
# Descripción: Define tablas de rutas y asociaciones para subredes públicas y privadas
##################################################################################

#########################################################
# Sección: Tabla de rutas pública
#########################################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

#########################################################
# Sección: Asociación tabla de rutas pública a subredes públicas
#########################################################
resource "aws_route_table_association" "public_az1_assoc" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_az2_assoc" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public_rt.id
}

#########################################################
# Sección: Tabla de rutas privada
#########################################################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "private-route-table"
  }
}

##################################################################
# Sección: Asociación tabla de rutas privada a subredes privadas
#################################################################
resource "aws_route_table_association" "private_az1_assoc" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_az2_assoc" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_rt.id
}