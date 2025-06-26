##################################################################################
# Archivo: ec2_autosc.tf -autoscaling
# Descripción: Define el Auto Scaling Group para instancias EC2 mediante un 
# Launch Template. También configura políticas de escalado automático conectadas 
# con alarmas de CloudWatch.
##################################################################################

############################
# Auto Scaling Group (ASG)
############################

resource "aws_autoscaling_group" "ecommerce_ec2_asg" {
  name                      = "ecommerce-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 300

  vpc_zone_identifier = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]

  launch_template {
    id      = aws_launch_template.ecommerce_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.ecommerce_tg.arn]

  tag {
    key                 = "Name"
    value               = "ec2-ecommerce"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  # ────────────────────────────────────────────────
  # Asegurar que el Launch Template exista antes
  # de crear este recurso (dependencia obligatoria)
  # ────────────────────────────────────────────────
  depends_on = [aws_launch_template.ecommerce_lt]

}

####################################
# Política de escalado hacia arriba
####################################

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "ecommerce-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecommerce_ec2_asg.name
}

####################################
# Política de escalado hacia abajo
####################################

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "ecommerce-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecommerce_ec2_asg.name
}