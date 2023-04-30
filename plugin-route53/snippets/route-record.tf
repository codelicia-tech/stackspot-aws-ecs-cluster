resource "aws_route53_record" "www" {
  zone_id = var.hosted_zone_id
  name    = "{{record_name}}"
  type    = "A"
  ttl     = 300
  records = [aws_lb.prod.public_ip]
}

