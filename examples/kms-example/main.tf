provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Environment = "example"
    ManagedBy   = "Terraform"
  }
}

module "eks_secrets_kms" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-secrets-kms?ref=v1.0.0"

  cluster_name = var.cluster_name
  tags         = local.common_tags
}
