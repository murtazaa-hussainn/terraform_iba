resource "aws_lb" "sp-frontend-app-alb" {
  name               = "sp-frontend-app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sp-public-frontend-alb-sg.id]
  subnets            = [aws_subnet.sp-subnet-public-1a.id, aws_subnet.sp-subnet-public-1b.id, aws_subnet.sp-subnet-public-1c.id]

  enable_deletion_protection = false

  tags = {
    Name = "sp-frontend-app-alb"
    Project = "DevOps Semester Project"
  }
}

resource "aws_lb_target_group" "sp-frontend-app-target-group" {
  name               = "sp-frontend-app-target-group"
  port               = 80
  protocol           = "HTTP"
  vpc_id             = aws_vpc.sp-vpc.id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "sp-frontend-app-target-group"
    Project = "DevOps Semester Project"
  }
}

resource "aws_lb_listener" "sp-frontend-app-listener" {
  load_balancer_arn = aws_lb.sp-frontend-app-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sp-frontend-app-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "sp-frontend-app-attachment" {
  target_group_arn = aws_lb_target_group.sp-frontend-app-target-group.arn
  target_id        = aws_instance.sp-private-ubuntu-frontend.id
  port             = 4000
}

output "sp-frontend-app-dns" {
  value = aws_lb.sp-frontend-app-alb.dns_name
}