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

module "route53_zone" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/route53-zone-lookup?ref=v1.0.0"

  zone_name    = var.domain_name
  private_zone = false
}

module "acm_certificate" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/acm-dns-certificate?ref=v1.0.0"

  domain_name     = var.domain_name
  route53_zone_id = module.route53_zone.zone_id
  tags            = local.common_tags
}
