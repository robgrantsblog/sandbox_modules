output "zone_id" {
  description = "ID of the matched Route53 hosted zone."
  value       = data.aws_route53_zone.this.zone_id
}

output "zone_arn" {
  description = "ARN of the matched Route53 hosted zone."
  value       = data.aws_route53_zone.this.arn
}
