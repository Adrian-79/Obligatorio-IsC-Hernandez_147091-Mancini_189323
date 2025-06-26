##################################################################################
# Archivo: launch_template_ec2.tf
# Descripción: Define el Launch Template para instancias EC2 con configuración base
##################################################################################

###############################################
# Recurso: aws_launch_template "app_lt"
# Descripción: Define el template base para EC2
###############################################
resource "aws_launch_template" "ecommerce_lt" {

  #########################################
  # Identificación de AMI e instancia
  #########################################
  name_prefix   = "ecommerce-lt"    # Prefijo del nombre del Launch Template
  image_id      = var.ami_id        # ID de la AMI personalizada creada previamente
  instance_type = var.instance_type # Tipo de instancia (por ejemplo, t3.micro)
  key_name      = var.key_name      # Nombre del key pair para acceso SSH

  #########################################
  # Perfil de IAM para permisos EC2
  #########################################
  iam_instance_profile {
    name = "LabInstanceProfile" # Perfil con permisos necesarios (SSM, etc.)
  }

  #########################################
  # Script de arranque con variables dinámicas
  #########################################
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    efs_id      = aws_efs_file_system.ecommerce_efs.id,
    efs_dns     = aws_efs_file_system.ecommerce_efs.dns_name,
    db_endpoint = aws_db_instance.rds_ecommerce.address,
    db_user     = var.rds_username,
    db_pass     = var.rds_password,
    db_name     = var.rds_db_name,
    github_repo = var.github_repo,
    region      = var.region
  }))

  #########################################
  # Asociar grupo de seguridad a EC2
  #########################################
  vpc_security_group_ids = [aws_security_group.ecommerce_sg_ec2.id]

  #########################################
  # Etiquetas aplicadas a instancias creadas
  #########################################
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
  }

  #########################################
  # Configuración de Metadata (para SSM, IMDSv2)
  #########################################
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  #########################################
  # Mapeo del disco raíz
  #########################################
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 20    # Tamaño del volumen EBS en GB
      volume_type           = "gp2" # Tipo de volumen EBS (general purpose)
      delete_on_termination = true  # Eliminar disco al terminar la instancia
    }
  }
}