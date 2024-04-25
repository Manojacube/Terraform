#locals { env_vars = yamldecode(file("../../prod_backend_env.json"))}
locals {
  json_content = jsondecode(file("${path.module}/../../${terraform.workspace}_backend_env.json"))
  
  backend_env = [
    for key, value in local.json_content :
    {
      name  = key
      value = value
    }
  ]
}

# ECS Task Role
data "aws_iam_policy_document" "ecs_task_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name_prefix        = "demo-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_doc.json
}

# ECS Execution Role
resource "aws_iam_role" "ecs_exec_role" {
  name_prefix        = "demo-ecs-exec-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_doc.json
}

resource "aws_iam_role_policy_attachment" "ecs_exec_role_policy" {
  role       = aws_iam_role.ecs_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.ecs_log_group_name
  retention_in_days = 14
}


resource "aws_ecs_task_definition" "example" {
  family             = var.ecs_task_family
  execution_role_arn = aws_iam_role.ecs_exec_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  cpu                = 256
  memory             = 256
  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([
    {
      name      = "${var.ecs_container_name}"
      image     = "${var.backend_ecr_image_location}"
      cpu       = 256
      memory    = 256
      portMappings = [
        {
          containerPort = "${var.backend_container_port}"
          hostPort      = "${var.backend_host_port}"
          protocol      = "HTTP"
        }
      ]
      environment = local.backend_env
    }
  ])
}


