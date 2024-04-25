variable "region" {
  description = "The AWS region"
}

variable "ecs_task_family" {
  description = "The family name of the ECS task definition"
}

variable "backend_host_port" {
  description = "The port on which the container listens"
}

variable "ecs_log_group_name" {
  description = "The name of the CloudWatch Logs log group"
}

variable "ecs_container_name" {
  description = "Name of the container"
  type        = string
}

variable "backend_ecr_image_location" {
  description = "Docker image for the container"
  type        = string
  #default     = "nginx:latest"  # Set the default value for nginx image
}

variable "backend_container_port" {
  
}