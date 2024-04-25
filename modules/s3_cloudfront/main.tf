resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = var.s3_bucket_id
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "noonum_frontend" {
  origin {
    origin_id               = var.s3_bucket_id
    domain_name             = var.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
  }

  aliases = ["${var.frontend_domain_name}"]   # Assuming var.domain_names is a list of alternate domain names

  enabled             = true
  wait_for_deployment = false
  default_root_object = "index.html"

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_bucket_id
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.frontend_ssl_certificate_arn  # Assuming var.ssl_certificate_arn is the ARN of your SSL certificate stored in ACM
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}