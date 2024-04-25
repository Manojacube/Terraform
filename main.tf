# Configure AWS Provider
provider "aws" {
  region = var.region
  #profile = "default"

}


# Create VPC
module "vpc" {
  source                 = "./modules/vpc"
  region                 = var.region
  project_name           = var.project_name
  vpc_cidr               = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
}

# create S3 bucket

module "s3_website" {
  source                  = "./modules/s3_website"
  frontend_website_bucket = var.frontend_website_bucket
  frontend_index_document = var.frontend_index_document
  region                  = var.region
}

# create Cloudfront

module "s3_cloudfront" {
  source                       = "./modules/s3_cloudfront"
  bucket_regional_domain_name  = module.s3_website.bucket_regional_domain_name
  s3_bucket_id                 = module.s3_website.s3_bucket_id
  index_document               = module.s3_website.index_document
  frontend_domain_name         = var.frontend_domain_name
  frontend_ssl_certificate_arn = var.frontend_ssl_certificate_arn
  depends_on                   = [module.s3_website]
}


module "Route53" {
  source = "./modules/Route53"

  frontend_cname_record_name             = var.frontend_cname_record_name
  frontend_cname_record_ttl              = var.frontend_cname_record_ttl
  frontend_cname_record_value            = var.frontend_cname_record_value # Replace with your CloudFront domain name
  frontend_route53_zone_id               = var.frontend_route53_zone_id    # Pass the route53_zone_id variable
  domain_name                            = var.frontend_domain_name
  cloudfront_distribution_domain_name    = module.s3_cloudfront.cloudfront_distribution_domain_name # Replace with your A record IP address
  cloudfront_distribution_hosted_zone_id = module.s3_cloudfront.cloudfront_distribution_hosted_zone_id
}


module "iam" {
  source         = "./modules/iam"
  bucket_id      = module.s3_website.s3_bucket_id
  cloudfront_arn = module.s3_cloudfront.cloudfront_distribution_arn
  bucket_arn     = module.s3_website.s3_bucket_arn
  depends_on     = [module.s3_cloudfront]
}


module "ECR" {
  source            = "./modules/ECR"
  region            = var.region
  ecr_registry_name = var.ecr_registry_name
}


module "SecurityGroup" {
  source              = "./modules/SecurityGroup"
  vpc_id              = module.vpc.vpc_id
  security_group_name = var.ecs_security_group_name
}


module "ECS" {
  source                                                          = "./modules/ECS"
  ecs_cluster_name                                                = var.ecs_cluster_name
  ecs_node_role_name                                              = var.ecs_node_role_name
  ecs_node_instance_profile_name                                  = var.ecs_node_sg_name_prefix
  ecs_node_sg_name_prefix                                         = var.ecs_node_sg_name_prefix
  ecs_ec2_launch_template_name_prefix                             = var.ecs_ec2_launch_template_name_prefix
  ecs_ec2_instance_type                                           = var.ecs_ec2_instance_type
  ecs_autoscaling_group_name                                      = var.ecs_ec2_instance_type
  vpc_id                                                          = module.vpc.vpc_id
  ecs_autoscaling_group_min_size                                  = var.ecs_autoscaling_group_min_size
  ecs_autoscaling_group_max_size                                  = var.ecs_autoscaling_group_max_size
  ecs_autoscaling_group_health_check_grace_period                 = var.ecs_autoscaling_group_health_check_grace_period
  ecs_autoscaling_group_health_check_type                         = var.ecs_autoscaling_group_health_check_type
  ecs_autoscaling_group_protect_from_scale_in                     = var.ecs_autoscaling_group_protect_from_scale_in
  ecs_autoscaling_group_tag_name                                  = var.ecs_autoscaling_group_tag_name
  ecs_autoscaling_group_tag_value                                 = var.ecs_autoscaling_group_tag_value
  ecs_capacity_provider_name                                      = var.ecs_capacity_provider_name
  ecs_capacity_provider_managed_termination_protection            = var.ecs_capacity_provider_managed_termination_protection
  ecs_capacity_provider_managed_scaling_maximum_scaling_step_size = var.ecs_capacity_provider_managed_scaling_maximum_scaling_step_size
  ecs_capacity_provider_managed_scaling_minimum_scaling_step_size = var.ecs_capacity_provider_managed_scaling_minimum_scaling_step_size
  ecs_capacity_provider_managed_scaling_status                    = var.ecs_capacity_provider_managed_scaling_status
  ecs_capacity_provider_managed_scaling_target_capacity           = var.ecs_capacity_provider_managed_scaling_target_capacity
  ecs_cluster_capacity_provider_base                              = var.ecs_cluster_capacity_provider_base
  ecs_cluster_capacity_provider_weight                            = var.ecs_cluster_capacity_provider_weight
  public_subnet_az1_cidr                                          = module.vpc.public_subnet_az1_id
  public_subnet_az2_cidr                                          = module.vpc.public_subnet_az2_id
  backend_host_port                                          = var.backend_host_port
}


module "ecs_taskdefinition" {
  source                     = "./modules/ecs_taskdefinition" # Assuming your ECS module is in a directory named "ecs_setup"
  ecs_task_family            = var.ecs_task_family
  region                     = var.region # Specify your desired AWS region here
  backend_ecr_image_location = var.backend_ecr_image_location
  ecs_container_name         = var.ecs_container_name
  ecs_log_group_name         = var.ecs_log_group_name
  backend_container_port     = var.backend_container_port
  backend_host_port          = var.backend_host_port
}


module "Service_tasks" {
  source                 = "./modules/Service_tasks"
  ecs_service_name       = var.ecs_service_name
  ecs_cluster_name       = module.ECS.ecs_cluster_arn
  ecs_task_family        = module.ecs_taskdefinition.task_definition_arn
  public_subnet_az1_cidr = module.vpc.public_subnet_az1_id
  port                   = var.backend_container_port
  ecs_task_desired_count = var.ecs_task_desired_count
  vpc_id                 = module.vpc.vpc_id

}

