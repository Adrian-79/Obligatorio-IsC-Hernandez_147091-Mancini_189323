##################################################################################
# Archivo: subnets.tf
# Descripción: Define las subredes públicas y privadas según la arquitectura
##################################################################################

#########################################################
# Sección: Subredes Públicas
#########################################################
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecommerce-public-subnet-az1"
    AZ   = "us-east-1a"
    Type = "public"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecommerce-public-subnet-az2"
    AZ   = "us-east-1b"
    Type = "public"
  }
}

########################################################
# Sección: Subredes Privadas
#######################################################
resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_az1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "ecommerce-private-subnet-az1"
    AZ   = "us-east-1a"
    Type = "private"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_az2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "ecommerce-private-subnet-az2"
    AZ   = "us-east-1b"
    Type = "private"
  }
}
