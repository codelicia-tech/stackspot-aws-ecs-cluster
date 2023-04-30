output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet_id2" {
  value = aws_subnet.private2.id
}

output "ecs_cluster" {
  value = aws_ecs_cluster.prod.id
}

output "vpc_id" {
  value = aws_vpc.prod.id
}

output alb_arn{
  value = aws_lb.prod.arn
}