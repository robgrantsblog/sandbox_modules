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

module "application_waf" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/alb-waf?ref=v1.0.0"

  name        = "${var.application_name}-waf"
  description = "AWS managed-rule protection for ${var.application_name}"
  tags        = local.common_tags
}
