resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  ip_address_type    = "ipv4"
  subnets = [ "subnet-0ced63dd5530743d8", "subnet-0dab73cb31c401274", "subnet-0870dc3ac621b22e0" ]

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_target_group" "http" {
  name        = "http"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "http"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}


resource "aws_lb_target_group_attachment" "http" {
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = aws_instance.ec2.id
  port             = 80
}