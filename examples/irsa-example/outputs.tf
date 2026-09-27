output "lb_controller_role_arn" {
  description = "IAM role ARN to annotate on the AWS Load Balancer Controller service account."
  value       = module.eks_irsa.lb_controller_role_arn
}

output "external_dns_role_arn" {
  description = "IAM role ARN to annotate on the external-dns service account."
  value       = module.eks_irsa.external_dns_role_arn
}
