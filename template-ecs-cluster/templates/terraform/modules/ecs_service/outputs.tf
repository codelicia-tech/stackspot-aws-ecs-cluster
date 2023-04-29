output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.prod.name
}

output "service_id" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.prod.id
}

output target_group_arn {
  value = aws_lb_target_group.prod.arn
}