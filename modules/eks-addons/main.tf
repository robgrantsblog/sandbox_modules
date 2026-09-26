resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.aws_load_balancer_controller_chart_version
  namespace  = var.namespace

  atomic  = true
  timeout = var.helm_timeout_seconds
  wait    = true

  values = [yamlencode({
    clusterName = var.cluster_name
    region      = var.aws_region
    vpcId       = var.vpc_id
    serviceAccount = {
      create = true
      name   = var.aws_load_balancer_controller_service_account_name
      annotations = {
        "eks.amazonaws.com/role-arn" = var.lb_controller_role_arn
      }
    }
  })]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = var.external_dns_chart_version
  namespace  = var.namespace

  atomic  = true
  timeout = var.helm_timeout_seconds
  wait    = true

  values = [yamlencode({
    provider = {
      name = "aws"
    }
    txtOwnerId    = var.cluster_name
    domainFilters = [var.domain_name]
    policy        = "upsert-only"
    env = [
      {
        name  = "AWS_REGION"
        value = var.aws_region
      }
    ]
    serviceAccount = {
      create = true
      name   = var.external_dns_service_account_name
      annotations = {
        "eks.amazonaws.com/role-arn" = var.external_dns_role_arn
      }
    }
  })]
}
