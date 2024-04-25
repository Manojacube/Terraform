

resource "aws_route53_record" "cname_record" {
  zone_id = var.frontend_route53_zone_id
  name    = var.frontend_cname_record_name
  type    = "CNAME"
  ttl     = var.frontend_cname_record_ttl
  records = [var.frontend_cname_record_value]
}

resource "aws_route53_record" "a_record" {
  zone_id = var.frontend_route53_zone_id
  name    = var.domain_name
  type    = "A"
   alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}
