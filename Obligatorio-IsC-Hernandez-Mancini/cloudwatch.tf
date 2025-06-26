##################################################################################
# Archivo: cloudwatch.tf
# Descripción: Define las alarmas de CloudWatch para activar políticas de escalado
# automático del Auto Scaling Group, basadas en el uso de CPU.
##################################################################################

############################################
# Alarma: CPU alta -> Escalado hacia arriba
############################################

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu_high_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarma para escalar hacia arriba cuando el uso de CPU > 70%"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecommerce_ec2_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

################################################
# Alarma: CPU baja -> Escalado hacia abajo
################################################

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu_low_alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Alarma para escalar hacia abajo cuando el uso de CPU < 30%"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecommerce_ec2_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}

##########################################################
# Alarma: Instancias no saludables en el ALB (target group)
##########################################################

resource "aws_cloudwatch_metric_alarm" "asg_unhealthy_instances" {
  alarm_name          = "asg_unhealthy_instances"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnhealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Detecta instancias no saludables en el ALB Target Group"

  dimensions = {
    LoadBalancer = aws_lb.ecommerce_alb.name
    TargetGroup  = aws_lb_target_group.ecommerce_tg.name
  }

  # Aquí podrías poner un SNS o acción para notificar
  alarm_actions = []
}

##############################
# Alarma: Conexiones RDS altas
##############################

resource "aws_cloudwatch_metric_alarm" "rds_connections_high" {
  alarm_name          = "rds_connections_high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "Alarma para conexiones altas en RDS"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.rds_ecommerce.id
  }

  alarm_actions = []
}

###################################################################
# Alarma: Errores familia 5xx(500, 502, 503, 504...) en ALB
###################################################################

resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "alb_5xx_errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  alarm_description   = "Alarma para errores familia 5xx en ALB"

  dimensions = {
    LoadBalancer = aws_lb.ecommerce_alb.name
  }

  alarm_actions = []
}