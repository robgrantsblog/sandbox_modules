provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-vpc?ref=v1.0.0"

  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr

  # Defaults: three AZs and one shared NAT gateway.
  availability_zone_count = var.availability_zone_count
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway

  tags = var.tags
}
