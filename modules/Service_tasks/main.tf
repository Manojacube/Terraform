resource "aws_ecs_service" "example" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_name
  task_definition = var.ecs_task_family
  desired_count   = var.ecs_task_desired_count
  launch_type     = "EC2"
/*
  deployment_controller {
    type = "CODE_DEPLOY"
  }*/

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  // Remove network_configuration block since using "bridge" network mode
}
