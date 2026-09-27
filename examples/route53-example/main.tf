provider "aws" {
  region = var.aws_region
}

module "route53_zone" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/route53-zone-lookup?ref=v1.0.0"

  zone_name    = var.zone_name
  private_zone = var.private_zone
}
