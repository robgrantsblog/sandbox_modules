output "zone_id" {
  description = "ID of the matched Route53 hosted zone."
  value       = module.route53_zone.zone_id
}

output "zone_arn" {
  description = "ARN of the matched Route53 hosted zone."
  value       = module.route53_zone.zone_arn
}
