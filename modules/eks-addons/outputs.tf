output "aws_load_balancer_controller_release_name" {
  description = "Helm release name for the AWS Load Balancer Controller."
  value       = helm_release.aws_load_balancer_controller.name
}

output "external_dns_release_name" {
  description = "Helm release name for external-dns."
  value       = helm_release.external_dns.name
}
