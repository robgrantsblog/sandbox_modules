# EKS Secrets KMS module

Creates a customer-managed AWS KMS key and alias intended for encrypting Kubernetes Secrets in EKS. The caller supplies the key ARN to the EKS cluster module's `kms_key_arn` input.

This is a reusable child module: it does not configure an AWS provider or backend. Configure the AWS provider and Terraform state in the calling root.

## Example

```hcl
module "eks_secrets_kms" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-secrets-kms?ref=v1.0.0"

  cluster_name = "production-app"
  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

module "eks" {
  # ...
  kms_key_arn = module.eks_secrets_kms.key_arn
}
```

For production, use a reviewed immutable Git tag, review the key policy and caller IAM permissions, and retain a deletion waiting period appropriate to your recovery requirements. The default key policy is AWS's account-root policy; the `key_policy` input can be used when a custom policy is required. Key rotation is enabled by default and deletion has a 30-day waiting period.

## Inputs

`cluster_name` is required. Optional inputs control the description, alias, deletion window (7–30 days), rotation, custom key policy, and tags.

## Outputs

- `key_arn`
- `key_id`
- `alias_arn`
- `alias_name`
