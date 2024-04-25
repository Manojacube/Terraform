
variable "vpc_id" {
  description = "ID of the VPC where the ECS service security group will be created"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}
variable "port" {
  
}
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_task_family" {
  description = "Task family for the ECS task definition"
  type        = string
}

variable "ecs_task_desired_count" {
  description = "Desired number of tasks for the ECS service"
  type        = number
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block of the public subnet where the ECS service will be deployed"
  type        = string
}