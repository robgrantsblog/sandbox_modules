provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  common_tags = {
    Environment = "example"
    ManagedBy   = "Terraform"
  }
}

module "eks_irsa" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-irsa?ref=v1.0.0"

  cluster_name          = var.cluster_name
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  route53_zone_arn      = var.route53_zone_arn
  tags                  = local.common_tags
}
