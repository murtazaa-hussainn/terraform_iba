resource "aws_route53_record" "app-doyend-xyz" {
  zone_id = "Z01941888FL44KO4ORZ5"  # Replace with your hosted zone ID
  name    = "app.doyend.xyz"
  type    = "A"
  alias {
    name = aws_lb.sp-frontend-app-alb.dns_name
    zone_id = aws_lb.sp-frontend-app-alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "backend-doyend-xyz" {
  zone_id = "Z01941888FL44KO4ORZ5"  # Replace with your hosted zone ID
  name    = "backend.doyend.xyz"
  type    = "A"
  alias {
    name = aws_lb.sp-backend-app-alb.dns_name
    zone_id = aws_lb.sp-backend-app-alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "metabase-doyend-xyz" {
  zone_id = "Z01941888FL44KO4ORZ5"  # Replace with your hosted zone ID
  name    = "metabase.doyend.xyz"
  type    = "A"
  alias {
    name = aws_lb.sp-metabase-alb.dns_name
    zone_id = aws_lb.sp-metabase-alb.zone_id
    evaluate_target_health = false
  }
}