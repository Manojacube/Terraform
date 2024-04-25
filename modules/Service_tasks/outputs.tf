output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.example.name
}

output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.example.id
}