region                                                          = "us-east-1"
project_name                                                    = "noonum-infra-terraform-prod"
vpc_cidr                                                        = "20.0.0.0/16"
public_subnet_az1_cidr                                          = "20.0.1.0/24"
public_subnet_az2_cidr                                          = "20.0.2.0/24"
frontend_website_bucket                                         = "noonum-frontend-website-prod"
frontend_index_document                                         = "index.html"
frontend_ssl_certificate_arn                                    = "arn:aws:acm:us-east-1:211125645506:certificate/841cdc93-837f-4ae3-968d-87afec130d61"
frontend_domain_name                                            = "noonum.net"
frontend_cname_record_ttl                                       = 300
frontend_cname_record_value                                     = "_dcec7136891a85b18cfe5cd529eba315.mhbtsbpdnt.acm-validations.aws."
frontend_route53_zone_id                                        = "Z01326832IR4TDNNGXBQL"
frontend_cname_record_name                                      = "_9cc514ff061085fcab5cacc5b6704393.noonum.net."
ecr_registry_name                                               = "noonum_ecr_prod"
ecs_log_group_name                                              = "/ecs/noonum-prod-log"
ecs_role_name                                                   = "noonum-ecs-node-role-prod"
ecs_security_group_name                                         = "noonum-ecs-node-sg-prod"
ecs_task_family                                                 = "noonum-app-prod"
ecs_service_name                                                = "noonum-service-prod"
ecs_task_desired_count                                          = "1"
ecs_autoscaling_ec2_max_size                                    = "5"
ecs_autoscaling_ec2_min_size                                    = "1"
ecs_autoscaling_ec2_desired_capacity                            = "1"
ec2_role_name                                                   = "EC2-Role-prod"
ec2_policy_name                                                 = "EC2-Policy-prod"
ecs_ec2_launch_template_name_prefix                             = "noonum-ecs-ec2-prod"
ecs_node_role_name                                              = "noonum-ecs-ec2node-role-prod"
ecs_node_instance_profile_name                                  = "noonum-ecs-node-profile-prod"
ecs_node_sg_name_prefix                                         = "noonum-ecs-ec2-node-sg-prod"
ecs_ec2_instance_type                                           = "t2.micro"
ecs_autoscaling_group_name                                      = "noonum-ecs-asg-prod"
ecs_autoscaling_group_min_size                                  = "1"
ecs_autoscaling_group_max_size                                  = "8"
ecs_autoscaling_group_health_check_grace_period                 = "0"
ecs_autoscaling_group_health_check_type                         = "EC2"
ecs_autoscaling_group_protect_from_scale_in                     = false
ecs_autoscaling_group_tag_name                                  = "noonum-prod"
ecs_autoscaling_group_tag_value                                 = "noonum-ecs-cluster-prod"
ecs_capacity_provider_name                                      = "noonum-ecs-ec2-prod"
ecs_capacity_provider_managed_termination_protection            = "DISABLED"
ecs_capacity_provider_managed_scaling_maximum_scaling_step_size = "2"
ecs_capacity_provider_managed_scaling_minimum_scaling_step_size = "1"
ecs_capacity_provider_managed_scaling_status                    = "ENABLED"
ecs_capacity_provider_managed_scaling_target_capacity           = "100"
ecs_cluster_capacity_provider_base                              = "1"
ecs_cluster_capacity_provider_weight                            = "100"
ecs_container_name                                              = "noonum"
ecs_cluster_name                                                = "noonum-cluster-prod"
backend_container_port                                          = 8000
backend_host_port                                               = 80
backend_ecr_image_location                                      = "211125645506.dkr.ecr.us-east-1.amazonaws.com/noonum_ecr_prod:latest"