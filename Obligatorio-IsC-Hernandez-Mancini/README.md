# 📂 Obligatorio - Arquitectura eCommerce en AWS - ISC 2025 - Aplicación tienda de Productos YEM-YEM
----------------------------------------------------------------------------------------------------------------------------------------------

## Descripción
Este proyecto aborda la migración y automatización del frontend de una tienda online hacia Amazon Web Services (AWS). Se utilizó Terraform para desplegar infraestructura escalable y de alta disponibilidad, cumpliendo buenas prácticas de IaC y DevOps.

## Modo de utilización del script deploy.sh, despliegue y acceso a la aplicación

Nota: ver instructivo Obligatorio_Hernandez_Mancini.pdf (pág. 22)


----------------------------------------------------------------------------------------------------------------------------------------------
## Objetivo

Diseñar y desplegar infraestructura en AWS que asegure:

✅ Alta disponibilidad (Multi-AZ)
✅ Escalabilidad automática (Auto Scaling Group)
✅ Seguridad (Security Groups)
✅ Monitoreo (CloudWatch)
✅ Trazabilidad y automatización (Terraform)

## Requerimientos

### Requisitos y dependencias

| Herramienta                   | Descripción                                          | Uso principal                            |
| ----------------------------- | ---------------------------------------------------- | ---------------------------------------- |
| **Terraform ≥ 1.4.6**         | Infraestructura como código (IaC)                    | Despliegue de la infraestructura en AWS  |
| **AWS CLI**                   | Línea de comandos para interactuar con AWS           | Configuración de credenciales y comandos |
| **Git**                       | Control de versiones y clonación del repositorio     | Gestión del código fuente                |
| **Docker** *(opcional)*       | Contenedor para herramientas como `asciicast2gif`    | Exportar sesiones como GIF animados      |
| **Visual Studio Code**        | Entorno de desarrollo con terminal integrada         | Edición y ejecución de scripts           |
| **WSL / Linux / Bash**        | Consola de comandos compatible con scripts Bash      | Ejecución de Terraform y scripts         |
| **Asciinema + asciicast2gif** | Grabación y exportación de terminal como GIF animado | Documentación visual del proceso         |

| Componente        | Servicios AWS involucrados                                      |
| ----------------- | --------------------------------------------------------------- |
| **Frontend**      | EC2, Launch Template, Auto Scaling Group, ALB, EFS              |
| **Base de datos** | Amazon RDS Aurora (MySQL Multi-AZ), S3 para backups             |
| **Red**           | VPC, subredes públicas/privadas, NAT Gateway, IGW, route tables |
| **Seguridad**     | Security Groups, claves SSH, AWS Systems Manager     |
| **Monitoreo**     | Amazon CloudWatch (métricas, logs, alarmas)                     |

----------------------------------------------------------------------------------------------------------------------------------------------

## Diagrama de arquitectura

![Obligatorio 2025 ISC - AWS](https://github.com/user-attachments/assets/e46376b8-96ad-427e-a84b-f33c69ca43a1)




----------------------------------------------------------------------------------------------------------------------------------------------

### Accesos y configuración

-Acceso SSH configurado mediante clave .pem con permisos chmod 400.

-Dirección IP pública del ISP permitida en formato /32 (definida en terraform.tfvars).

-Acceso alternativo por AWS Systems Manager (SSM).

----------------------------------------------------------------------------------------------------------------------------------------------

Infraestructura Terraform

Obligatorio-IsC-Hernandez_147091-Mancini_189323/Obligatorio-IsC-Hernandez-Mancini/Obligatorio-IsC-Hernandez_147091-Mancini_189323/

![image](https://github.com/user-attachments/assets/d29cb960-6e5d-4bd9-8cf0-56ca369566e0)


----------------------------------------------------------------------------------------------------------------------------------------------


| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.ecommerce_ec2_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.alb_5xx_errors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.asg_unhealthy_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rds_connections_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_instance.rds_ecommerce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.rds_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_efs_file_system.ecommerce_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.efs_mt_az1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.efs_mt_az2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_launch_template.ecommerce_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.ecommerce_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.ecommerce_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_az1_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_az2_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_az1_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_az2_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.ecommerce_bastion_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecommerce_sg_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecommerce_sg_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecommerce_sg_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecommerce_sg_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.efs_ingress_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.permitir_ssh_para_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.private_az1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_az2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_az1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_az2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_cidr"></a> [admin\_cidr](#input\_admin\_cidr) | CIDR para acceso administrativo (SSH) | `string` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID para instancias EC2 (Amazon Linux 2) | `string` | n/a | yes |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | Capacidad deseada de instancias en el ASG | `number` | `2` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Número máximo de instancias en el ASG | `number` | `4` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Número mínimo de instancias en el ASG | `number` | `2` | no |
| <a name="input_db_endpoint"></a> [db\_endpoint](#input\_db\_endpoint) | Endpoint externo o personalizado de la base de datos | `string` | n/a | yes |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | URL del repositorio Git con el código de la aplicación | `string` | `"github_repo"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Tipo de instancia EC2 | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Nombre del key pair SSH | `string` | n/a | yes |
| <a name="input_private_subnet_az1_cidr"></a> [private\_subnet\_az1\_cidr](#input\_private\_subnet\_az1\_cidr) | CIDR para subred privada en AZ1 | `string` | `"10.0.11.0/24"` | no |
| <a name="input_private_subnet_az2_cidr"></a> [private\_subnet\_az2\_cidr](#input\_private\_subnet\_az2\_cidr) | CIDR para subred privada en AZ2 | `string` | `"10.0.12.0/24"` | no |
| <a name="input_public_subnet_az1_cidr"></a> [public\_subnet\_az1\_cidr](#input\_public\_subnet\_az1\_cidr) | CIDR para subred pública en AZ1 | `string` | `"10.0.1.0/24"` | no |
| <a name="input_public_subnet_az2_cidr"></a> [public\_subnet\_az2\_cidr](#input\_public\_subnet\_az2\_cidr) | CIDR para subred pública en AZ2 | `string` | `"10.0.2.0/24"` | no |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | Almacenamiento asignado a RDS (GB) | `number` | `20` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | Nombre de la base de datos | `string` | `"ecommerce"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | Clase de instancia para RDS | `string` | `"db.t3.micro"` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | Contraseña para RDS | `string` | n/a | yes |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | Usuario maestro para RDS | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Región AWS donde se desplegarán los recursos | `string` | `"us-east-1"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block para la VPC principal | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS del Application Load Balancer |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | Nombre del Auto Scaling Group de la aplicación |
| <a name="output_ec2_security_group_id"></a> [ec2\_security\_group\_id](#output\_ec2\_security\_group\_id) | ID del Security Group asociado a las instancias EC2 |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | ID del sistema de archivos EFS |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | ID del Launch Template para EC2 |
| <a name="output_private_subnet_az1_id"></a> [private\_subnet\_az1\_id](#output\_private\_subnet\_az1\_id) | ID de la subred privada en AZ1 |
| <a name="output_private_subnet_az2_id"></a> [private\_subnet\_az2\_id](#output\_private\_subnet\_az2\_id) | ID de la subred privada en AZ2 |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | Endpoint de la base de datos RDS |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | Puerto de conexión de la base de datos RDS |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID de la VPC creada |

----------------------------------------------------------------------------------------------------------------------------------------------


# Buenas prácticas implementadas

-IaC con Terraform y versionado con Git

-Modularización de infraestructura

-Uso de variables parametrizadas

-Logs centralizados (CloudWatch)

-Acceso sin claves por SSM

-Auto Scaling con Launch Templates

-Multi-AZ para RDS, EC2, EFS y se hicieron pruebas con S3 para almacenamiento de logs.

