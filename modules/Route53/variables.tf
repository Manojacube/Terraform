variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

variable "frontend_cname_record_name" {
  description = "The name for the CNAME record"
  type        = string
}

variable "frontend_cname_record_ttl" {
  description = "The TTL for the CNAME record"
  type        = number
}

variable "frontend_cname_record_value" {
  description = "The value for the CNAME record"
  type        = string
}
/*
variable "a_record_name" {
  description = "The name for the A record"
  type        = string
}*/
variable "frontend_route53_zone_id" {
  
}
/*
variable "a_record_ttl" {
  description = "The TTL for the A record"
  type        = number
}
*/
variable "cloudfront_distribution_domain_name" {
  description = "The value for the A record"
  type        = string
}

variable "cloudfront_distribution_hosted_zone_id" {
  
}
