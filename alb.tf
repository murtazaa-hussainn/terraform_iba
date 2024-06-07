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

resource "aws_lb_listener" "sp-frontend-app-listener-https" {
  load_balancer_arn = aws_lb.sp-frontend-app-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:058264531795:certificate/16d5b4ef-7998-4415-9cc9-e8c48f1b124b"

  default_action {
    type             = "forward"
    forward {
      target_group {
      arn = aws_lb_target_group.sp-frontend-app-target-group.arn
      }
    } 
  }
}

resource "aws_lb_listener" "sp-frontend-app-listener-http" {
  load_balancer_arn = aws_lb.sp-frontend-app-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type  = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
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

resource "aws_lb" "sp-backend-app-alb" {
  name               = "sp-backend-app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sp-public-backend-alb-sg.id]
  subnets            = [aws_subnet.sp-subnet-public-1a.id, aws_subnet.sp-subnet-public-1b.id, aws_subnet.sp-subnet-public-1c.id]

  enable_deletion_protection = false

  tags = {
    Name = "sp-backend-app-alb"
    Project = "DevOps Semester Project"
  }
}

resource "aws_lb_target_group" "sp-backend-app-target-group" {
  name               = "sp-backend-app-target-group"
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
    Name = "sp-backend-app-target-group"
    Project = "DevOps Semester Project"
  }
}

resource "aws_lb_listener" "sp-backend-app-listener-https" {
  load_balancer_arn = aws_lb.sp-backend-app-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:058264531795:certificate/16d5b4ef-7998-4415-9cc9-e8c48f1b124b"

  default_action {
    type             = "forward"
    forward {
      target_group {
      arn = aws_lb_target_group.sp-backend-app-target-group.arn
      }
    } 
  }
}

resource "aws_lb_listener" "sp-backend-app-listener-http" {
  load_balancer_arn = aws_lb.sp-backend-app-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type  = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group_attachment" "sp-backend-app-attachment" {
  target_group_arn = aws_lb_target_group.sp-backend-app-target-group.arn
  target_id        = aws_instance.sp-private-ubuntu-backend.id
  port             = 5000
}

output "sp-backend-app-dns" {
  value = aws_lb.sp-backend-app-alb.dns_name
}

resource "aws_lb" "sp-metabase-alb" {
  name               = "sp-metabase-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sp-public-metabase-alb-sg.id]
  subnets            = [aws_subnet.sp-subnet-public-1a.id, aws_subnet.sp-subnet-public-1b.id, aws_subnet.sp-subnet-public-1c.id]

  enable_deletion_protection = false

  tags = {
    Name = "sp-metabase-alb"
    Project = "DevOps Semester Project"
  }
}

resource "aws_lb_target_group" "sp-metabase-target-group" {
  name               = "sp-metabase-target-group"
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
    Name = "sp-metabase-target-group"
    Project = "DevOps Semester Project"
  }
}

resource "aws_lb_listener" "sp-metabase-listener-https" {
  load_balancer_arn = aws_lb.sp-metabase-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:058264531795:certificate/16d5b4ef-7998-4415-9cc9-e8c48f1b124b"

  default_action {
    type             = "forward"
    forward {
      target_group {
      arn = aws_lb_target_group.sp-metabase-target-group.arn
      }
    } 
  }
}

resource "aws_lb_listener" "sp-metabase-listener-http" {
  load_balancer_arn = aws_lb.sp-metabase-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type  = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group_attachment" "sp-metabase-attachment" {
  target_group_arn = aws_lb_target_group.sp-metabase-target-group.arn
  target_id        = aws_instance.sp-private-ubuntu-metabase.id
  port             = 3000
}

output "sp-metabase-dns" {
  value = aws_lb.sp-metabase-alb.dns_name
}