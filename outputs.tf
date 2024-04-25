# Export the Cloudfront ID

output "cloudfront_distribution_id" {
  description = "The ID for Cloudfront Distribution"
  value       = module.s3_cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  value = module.s3_cloudfront.cloudfront_distribution_arn

}
output "cloudfront_distribution_domain_name" {
  value = module.s3_cloudfront.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = module.s3_cloudfront.cloudfront_distribution_hosted_zone_id
}



# Export the S3 Bucket ID

output "s3_bucket_id" {
  description = "The ID of S3 Bucket"
  value       = module.s3_website.s3_bucket_id
}

# Export the s3 bucket ARN

output "s3_bucket_arn" {
  description = "The ARN of S3 Bucket"
  value       = module.s3_website.s3_bucket_arn
}

# Export the website_URL

output "website_url" {
  description = "The URL of S3 Bucket"
  value       = module.s3_website.website_url
}
# Export the Region

output "region" {
  value = module.vpc.region
}

# Export the Project Name

output "project_name" {
  value = module.vpc.project_name
}

# Export the VPC ID

output "vpc_id" {
  value = module.vpc.vpc_id
}

# Export the Internet Gateway

output "internet_gateway" {
  value = module.vpc.internet_gateway
}

# Export the Public Subnet AZ1 ID

output "public_subnet_az1_id" {
  value = module.vpc.public_subnet_az1_id
}

# Export the Public Subnet AZ2 ID

output "public_subnet_az2_id" {
  value = module.vpc.public_subnet_az2_id
}


output "repository_url" {
  value = module.ECR.repository_url
}

output "ecs_cluster_arn" {
  value = module.ECS.ecs_cluster_arn
}


output "task_definition_arn" {
  value = module.ecs_taskdefinition.task_definition_arn

}

output "ecs_node_sg_id" {
  value = module.SecurityGroup.ecs_node_sg_id
}

output "service_name" {
  value = module.Service_tasks.service_name
}

output "service_id" {
  value = module.Service_tasks.service_id
}