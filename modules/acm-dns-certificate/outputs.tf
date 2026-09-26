output "certificate_arn" {
  description = "ARN of the DNS-validated ACM certificate."
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "certificate_domain_name" {
  description = "Primary domain name on the ACM certificate."
  value       = aws_acm_certificate.this.domain_name
}
