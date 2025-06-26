##################################################################################
# Archivo: ec2_b_host.tf  -  bastion_host.tf
# Descripción: Subnet pública, Security Group e instancia Bastion Host con SSM
##################################################################################
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_az1.id
  key_name                    = var.key_name
  associate_public_ip_address = true

  iam_instance_profile = "LabInstanceProfile"

  vpc_security_group_ids = [aws_security_group.ecommerce_bastion_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              EOF

  tags = {
    Name = "ecommerce_bastion_host"
  }
}