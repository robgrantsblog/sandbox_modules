output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "cluster_version" {
  description = "Kubernetes version running on the EKS control plane."
  value       = module.eks.cluster_version
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint for the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate authority data for the cluster."
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS control plane."
  value       = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  description = "ARN of the cluster OIDC provider, used by IAM roles for service accounts."
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  description = "URL of the cluster OIDC issuer."
  value       = module.eks.oidc_provider
}
