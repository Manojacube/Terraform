output "cname_record_fqdn" {
  value = aws_route53_record.cname_record.fqdn
}

output "a_record_fqdn" {
  value = aws_route53_record.a_record.fqdn
}
