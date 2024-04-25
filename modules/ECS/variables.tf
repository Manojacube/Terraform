variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_node_role_name" {
  description = "Name for the ECS node IAM role"
  type        = string
}

variable "ecs_node_instance_profile_name" {
  description = "Name for the ECS node IAM instance profile"
  type        = string
}

variable "ecs_node_sg_name_prefix" {
  description = "Name prefix for the ECS node security group"
  type        = string
}

variable "ecs_ec2_launch_template_name_prefix" {
  description = "Name prefix for the ECS EC2 launch template"
  type        = string
}

variable "backend_host_port" {}


variable "ecs_ec2_instance_type" {
  description = "Instance type for ECS EC2 instances"
  type        = string
}

variable "ecs_autoscaling_group_name" {
  description = "Name for the ECS autoscaling group"
  type        = string
}

variable "ecs_autoscaling_group_min_size" {
  description = "Minimum size for the ECS autoscaling group"
  type        = number
}

variable "ecs_autoscaling_group_max_size" {
  description = "Maximum size for the ECS autoscaling group"
  type        = number
}

variable "ecs_autoscaling_group_health_check_grace_period" {
  description = "Health check grace period for the ECS autoscaling group"
  type        = number
}

variable "ecs_autoscaling_group_health_check_type" {
  description = "Health check type for the ECS autoscaling group"
  type        = string
}

variable "ecs_autoscaling_group_protect_from_scale_in" {
  description = "Whether to protect the ECS autoscaling group from scale in"
  type        = bool
}

variable "ecs_autoscaling_group_tag_name" {
  description = "Tag name for the ECS autoscaling group"
  type        = string
}

variable "ecs_autoscaling_group_tag_value" {
  description = "Tag value for the ECS autoscaling group"
  type        = string
}

variable "ecs_capacity_provider_name" {
  description = "Name for the ECS capacity provider"
  type        = string
}

variable "ecs_capacity_provider_managed_termination_protection" {
  description = "Whether managed termination protection is enabled for the ECS capacity provider"
  type        = string
}

variable "ecs_capacity_provider_managed_scaling_maximum_scaling_step_size" {
  description = "Maximum scaling step size for the managed scaling of the ECS capacity provider"
  type        = number
}

variable "ecs_capacity_provider_managed_scaling_minimum_scaling_step_size" {
  description = "Minimum scaling step size for the managed scaling of the ECS capacity provider"
  type        = number
}

variable "ecs_capacity_provider_managed_scaling_status" {
  description = "Status of the managed scaling for the ECS capacity provider"
  type        = string
}

variable "ecs_capacity_provider_managed_scaling_target_capacity" {
  description = "Target capacity for the managed scaling of the ECS capacity provider"
  type        = number
}

variable "ecs_cluster_capacity_provider_base" {
  description = "Base value for the default capacity provider strategy of the ECS cluster"
  type        = number
}

variable "ecs_cluster_capacity_provider_weight" {
  description = "Weight value for the default capacity provider strategy of the ECS cluster"
  type        = number
}

variable "vpc_id" {
  
}


variable "public_subnet_az1_cidr" {
  
}

variable "public_subnet_az2_cidr" {
  
}