###################################################################################
# Archivo: load_balancer.tf
# Descripción: Definimos el Application Load Balancer (ALB) y Listener
##################################################################################

##############################
# Application Load Balancer
##############################

resource "aws_lb" "ecommerce_alb" {
  name               = "alb-ecommerce"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecommerce_sg_alb.id]

  subnets = [
    aws_subnet.public_az1.id,
    aws_subnet.public_az2.id
  ]

  tags = {
    Name = "ecommerce-alb"
  }
}

##############################
# Listener HTTP del ALB
##############################

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ecommerce_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecommerce_tg.arn
  }
}
