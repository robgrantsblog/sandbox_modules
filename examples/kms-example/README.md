# EKS Secrets KMS module example

This standalone Terraform root demonstrates using the published `eks-secrets-kms` module to create a customer-managed AWS KMS key and alias for EKS Kubernetes Secret encryption. It does not create an EKS cluster.

The example applies `Environment = "example"` and `ManagedBy = "Terraform"` tags to the key. Change the tag values in `main.tf` to match your environment.

## Prerequisites

- Terraform >= 1.5
- AWS credentials configured for the AWS provider (for example, through an AWS profile or environment variables)
- Permissions to create and describe KMS keys and aliases

## Use

From this directory:

```sh
terraform init
terraform plan
terraform apply
```

The AWS region defaults to `us-east-1`; override it with a gitignored `terraform.tfvars` file or `-var`. The example's `cluster_name` defaults to `example-eks` and is used for the key description and default alias name.

The `key_arn` output is intended to be passed as `kms_key_arn` to the EKS cluster module. For example:

```hcl
module "eks" {
  # Other EKS settings omitted.
  kms_key_arn = module.eks_secrets_kms.key_arn
}
```

The module enables annual key rotation by default and uses a 30-day deletion waiting period by default. KMS keys incur ongoing charges. Review the plan and AWS pricing before applying; destroying the key schedules its deletion after the configured waiting period.
