provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--region", var.aws_region, "--cluster-name", var.cluster_name]
    }
  }
}

module "eks_addons" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-addons?ref=v1.0.0"

  cluster_name           = var.cluster_name
  aws_region             = var.aws_region
  vpc_id                 = var.vpc_id
  domain_name            = var.domain_name
  lb_controller_role_arn = var.lb_controller_role_arn
  external_dns_role_arn  = var.external_dns_role_arn

  aws_load_balancer_controller_chart_version = var.aws_load_balancer_controller_chart_version
  external_dns_chart_version                 = var.external_dns_chart_version
}
