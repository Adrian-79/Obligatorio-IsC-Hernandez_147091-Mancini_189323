##################################################################################
# Archivo: efs.tf
# Descripción: Define el sistema de archivos EFS para almacenamiento compartido
##################################################################################
resource "aws_efs_file_system" "ecommerce_efs" {
  creation_token = "ecommerce-efs-token"

  tags = {
    Name = "ecommerce-efs"
  }
}

#Asociar SG a EFS Mount Targets
resource "aws_efs_mount_target" "efs_mt_az1" {
  file_system_id  = aws_efs_file_system.ecommerce_efs.id
  subnet_id       = aws_subnet.private_az1.id
  security_groups = [aws_security_group.ecommerce_sg_efs.id]
}

resource "aws_efs_mount_target" "efs_mt_az2" {
  file_system_id  = aws_efs_file_system.ecommerce_efs.id
  subnet_id       = aws_subnet.private_az2.id
  security_groups = [aws_security_group.ecommerce_sg_efs.id]
}


