# EKS IRSA roles module

Creates IAM Roles for Service Accounts (IRSA) for the AWS Load Balancer Controller and external-dns. The external-dns role is scoped to the supplied Route53 hosted-zone ARN. Both roles trust only the supplied EKS OIDC provider and their corresponding Kubernetes service account identities.

This is a reusable child module: it does not configure an AWS provider, backend, state, or credentials. Configure the AWS provider in the calling root module.

## Example

```hcl
module "eks_irsa" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-irsa?ref=v1.0.0"

  cluster_name        = module.eks.cluster_name
  eks_oidc_provider_arn = module.eks.oidc_provider_arn
  route53_zone_arn     = module.dns.route53_zone_arn

  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

Use a reviewed, immutable Git tag for production. Grant the module caller only the IAM permissions needed to create these roles and policies. The upstream IAM module attaches AWS Load Balancer Controller permissions and external-dns permissions limited to `route53_zone_arn`; review those upstream policies and update module versions through a tested release process.

## Inputs

Required: `cluster_name`, `eks_oidc_provider_arn`, and `route53_zone_arn`.

Optional service-account identities default to `kube-system:aws-load-balancer-controller` and `kube-system:external-dns`. Optional `tags` defaults to `{}`.

## Outputs

- `lb_controller_role_arn`
- `external_dns_role_arn`
