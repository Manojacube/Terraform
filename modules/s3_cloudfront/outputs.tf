output "cloudfront_distribution_id" {
    description = "ID of cloudfront"
    value = aws_cloudfront_distribution.noonum_frontend.id
  
}

output "cloudfront_distribution_arn" {
    value = aws_cloudfront_distribution.noonum_frontend.arn
  
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.noonum_frontend.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.noonum_frontend.hosted_zone_id
}
