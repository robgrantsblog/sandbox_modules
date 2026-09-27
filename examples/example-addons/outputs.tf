output "aws_load_balancer_controller_release_name" {
  description = "Helm release name for the AWS Load Balancer Controller."
  value       = module.eks_addons.aws_load_balancer_controller_release_name
}

output "external_dns_release_name" {
  description = "Helm release name for external-dns."
  value       = module.eks_addons.external_dns_release_name
}
