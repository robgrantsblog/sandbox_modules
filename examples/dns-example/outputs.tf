output "route53_zone_id" {
  description = "ID of the existing public Route53 hosted zone."
  value       = module.route53_zone.zone_id
}

output "certificate_arn" {
  description = "ARN of the DNS-validated ACM certificate."
  value       = module.acm_certificate.certificate_arn
}

output "certificate_domain_name" {
  description = "Primary domain name covered by the certificate."
  value       = module.acm_certificate.certificate_domain_name
}
