# Create a security group to allow traffic to alb
resource "aws_security_group" "alb" {
  name_prefix = "alb-sg"
  vpc_id      = aws_vpc.prod.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create an Application Load Balancer
resource "aws_lb" "prod" {
  name               = "prod-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id,aws_subnet.public2.id]
  security_groups    = [aws_security_group.alb.id]
  tags = {
    Name = "prod-alb"
  }
}

# resource "aws_route53_record" "www" {
#   zone_id = var.hosted_zone_id
#   name    = "www.example.com"
#   type    = "A"
#   ttl     = 300
#   records = [aws_lb.prod.public_ip]
# }