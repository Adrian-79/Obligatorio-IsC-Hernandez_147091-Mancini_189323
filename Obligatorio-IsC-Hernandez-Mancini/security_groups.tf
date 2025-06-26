##################################################################################
# Archivo: security_groups.tf
# Descripción: Define los Security Groups para:
# - ALB (HTTP/HTTPS)
# - EC2 App (con EFS, RDS)
# - RDS (MySQL)
# - EFS (NFS TCP/UDP)
# - Bastion host (SSH opcional)
##################################################################################
#########################
# SG para ALB (Público)
########################
resource "aws_security_group" "ecommerce_sg_alb" {
  name        = "ecommerce_sg_alb"
  description = "Security group para ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP desde internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS desde internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-alb"
  }
}

###############################
# SG para EC2 App (Privadas)
###############################
resource "aws_security_group" "ecommerce_sg_ec2" {
  name        = "ecommerce_sg_ec2"
  description = "Security group para instancias EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP desde ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ecommerce_sg_alb.id]
  }

  ingress {
    description     = "HTTPS desde ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ecommerce_sg_alb.id]
  }

  ingress {
    description = "SSH desde IP del administrador"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr] #["0.0.0.0/0"] evitar usar /32
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-ec2"
  }
}

#######################################
# SG para RDS
#######################################
resource "aws_security_group" "ecommerce_sg_rds" {
  name        = "ecommerce_sg_rds"
  description = "Security group para RDS MySQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL desde EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecommerce_sg_ec2.id]
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-rds"
  }
}

##########################################################
# SG para EFS (Puerto TCP y UDP 2049 desde EC2)
##########################################################
resource "aws_security_group" "ecommerce_sg_efs" {
  name        = "ecommerce_sg_efs"
  description = "Security group para acceso NFS de EFS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Permitir NFS TCP desde instancias EC2"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ecommerce_sg_ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-efs"
  }
}

resource "aws_security_group_rule" "efs_ingress_udp" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "udp"
  security_group_id        = aws_security_group.ecommerce_sg_efs.id
  source_security_group_id = aws_security_group.ecommerce_sg_ec2.id
  description              = "Permitir NFS UDP desde EC2"
}

####################################################
# SG para Bastion Host
####################################################
resource "aws_security_group" "ecommerce_bastion_sg" {
  name        = "ecommerce_bastion_sg"
  description = "Permitir SSH desde tu IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH desde IP administrador"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group_rule" "permitir_ssh_para_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecommerce_sg_ec2.id
  source_security_group_id = aws_security_group.ecommerce_bastion_sg.id
  description              = "Allow SSH from Bastion host"
}
