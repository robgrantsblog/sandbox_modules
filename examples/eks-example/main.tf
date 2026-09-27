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

module "eks" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-cluster?ref=v1.0.0"

  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  kms_key_arn        = var.kms_key_arn

  access_entries = {
    cluster_admin = {
      principal_arn = var.cluster_admin_role_arn
      policy_associations = {
        cluster_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  # The module defaults to a private-only API endpoint. Operators and Terraform
  # must be able to reach the private endpoint from the VPC or an attached VPN.
  tags = local.common_tags
}
