output "s3_bucket_id" {
  description = "The ID of S3 Bucket"
  value = aws_s3_bucket.website_bucket.id
}

output "s3_bucket_arn" {
    description = "The ARN of S3 Bucket"
    value = aws_s3_bucket.website_bucket.arn
}

output "website_url" {
    description = "The URL of S3 Bucket"
    value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website-${var.region}.amazonaws.com"  
}

output "index_document" {
  description = "The index Document of s3 website"
  value = var.frontend_index_document
}

output "bucket_regional_domain_name" {
  description = "Regional domain name of s3 bucket"
  value = aws_s3_bucket.website_bucket.bucket_regional_domain_name
  
}