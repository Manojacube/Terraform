# --- ECS Cluster ---

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

# --- ECS Node Role ---

data "aws_iam_policy_document" "ecs_node_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_node_role" {
  name               = var.ecs_node_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_node_doc.json
}

resource "aws_iam_role_policy_attachment" "ecs_node_role_policy" {
  role       = aws_iam_role.ecs_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_node" {
  name = var.ecs_node_instance_profile_name
  path = "/ecs/instance/"
  role = aws_iam_role.ecs_node_role.name
}

# --- ECS Node SG ---

resource "aws_security_group" "ecs_node_sg" {
  name_prefix = var.ecs_node_sg_name_prefix
  vpc_id      = var.vpc_id
  ingress {
    from_port   = var.backend_host_port
    to_port     = var.backend_host_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- ECS Launch Template ---

data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name_prefix            = var.ecs_ec2_launch_template_name_prefix
  image_id               = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type          = var.ecs_ec2_instance_type
  vpc_security_group_ids = [aws_security_group.ecs_node_sg.id]
  key_name               = "demo"  # Add this line to specify the keypair name

  iam_instance_profile { arn = aws_iam_instance_profile.ecs_node.arn }
  monitoring { enabled = true }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config;
    EOF
  )
}


# --- ECS ASG ---

resource "aws_autoscaling_group" "ecs" {
  name                       = var.ecs_autoscaling_group_name
  vpc_zone_identifier        = [var.public_subnet_az1_cidr, var.public_subnet_az2_cidr]
  min_size                   = var.ecs_autoscaling_group_min_size
  max_size                   = var.ecs_autoscaling_group_max_size
  health_check_grace_period = var.ecs_autoscaling_group_health_check_grace_period
  health_check_type         = var.ecs_autoscaling_group_health_check_type
  protect_from_scale_in     = var.ecs_autoscaling_group_protect_from_scale_in

  launch_template {
    id      = aws_launch_template.ecs_ec2.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.ecs_autoscaling_group_tag_name
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = var.ecs_autoscaling_group_tag_value
    propagate_at_launch = true
  }
}

# --- ECS Capacity Provider ---

resource "aws_ecs_capacity_provider" "main" {
  name = var.ecs_capacity_provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = var.ecs_capacity_provider_managed_termination_protection

    managed_scaling {
      maximum_scaling_step_size = var.ecs_capacity_provider_managed_scaling_maximum_scaling_step_size
      minimum_scaling_step_size = var.ecs_capacity_provider_managed_scaling_minimum_scaling_step_size
      status                    = var.ecs_capacity_provider_managed_scaling_status
      target_capacity           = var.ecs_capacity_provider_managed_scaling_target_capacity
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = [aws_ecs_capacity_provider.main.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.main.name
    base              = var.ecs_cluster_capacity_provider_base
    weight            = var.ecs_cluster_capacity_provider_weight
  }
}
