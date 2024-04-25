resource "aws_s3_bucket" "website_bucket" {
  bucket = var.frontend_website_bucket
  force_destroy = true

  tags = {
    Name = "Bucket for website ${var.frontend_website_bucket}"
  }
}

resource "aws_s3_bucket_versioning" "website_versioning" {
  bucket = aws_s3_bucket.website_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = var.frontend_index_document
  }
}

resource "aws_s3_bucket_public_access_block" "website_bucket_allow_public_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}


  
