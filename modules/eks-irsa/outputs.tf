output "lb_controller_role_arn" {
  description = "IAM role ARN assumed by the AWS Load Balancer Controller service account."
  value       = module.lb_controller_irsa_role.iam_role_arn
}

output "external_dns_role_arn" {
  description = "IAM role ARN assumed by the external-dns service account."
  value       = module.external_dns_irsa_role.iam_role_arn
}
