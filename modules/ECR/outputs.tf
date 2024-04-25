output "repository_url" {
  description = "The URL of the created ECR repository."
  value       = aws_ecr_repository.noonum_registry.repository_url
}
