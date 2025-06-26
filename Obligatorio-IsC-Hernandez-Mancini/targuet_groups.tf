##############################
# Archivo: target_groups.tf
# Target Group para EC2
##############################

resource "aws_lb_target_group" "ecommerce_tg" {
  name        = "ecommerce-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = "/healthcheck.php"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 10
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "ecommerce-target-group"
  }
}
