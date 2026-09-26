data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  selected_azs = slice(
    data.aws_availability_zones.available.names,
    0,
    var.availability_zone_count,
  )

  eks_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = local.selected_azs
  private_subnets = [for k in range(var.availability_zone_count) : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets  = [for k in range(var.availability_zone_count) : cidrsubnet(var.vpc_cidr, 4, k + var.availability_zone_count)]

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true

  tags = var.tags

  public_subnet_tags = merge(var.tags, local.eks_subnet_tags, {
    "kubernetes.io/role/elb" = "1"
  })

  private_subnet_tags = merge(var.tags, local.eks_subnet_tags, {
    "kubernetes.io/role/internal-elb" = "1"
  })
}
