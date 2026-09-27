output "key_arn" {
  description = "KMS key ARN to pass to the EKS cluster module's kms_key_arn input."
  value       = module.eks_secrets_kms.key_arn
}

output "key_id" {
  description = "ID of the customer-managed KMS key."
  value       = module.eks_secrets_kms.key_id
}

output "alias_arn" {
  description = "ARN of the KMS alias."
  value       = module.eks_secrets_kms.alias_arn
}

output "alias_name" {
  description = "Name of the KMS alias."
  value       = module.eks_secrets_kms.alias_name
}
