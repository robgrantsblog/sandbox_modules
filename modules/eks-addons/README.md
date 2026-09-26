# EKS add-ons module

Installs the AWS Load Balancer Controller and external-dns into an existing EKS cluster using Helm. The AWS provider, Helm provider (including Kubernetes authentication), cluster, VPC, and IRSA roles are owned by the caller.

The module intentionally has no provider or backend block. Terraform provider configuration is inherited from the root module. The configured Helm provider must already be authenticated to the target EKS cluster.

## Security behavior

- Both Helm chart versions are required inputs; there are no floating `latest` versions. Select and review chart versions compatible with the target EKS/Kubernetes version, then commit the calling root's provider lockfile.
- external-dns is restricted to the supplied domain filter, receives a scoped IRSA role, and runs with `upsert-only` policy so it does not delete DNS records.
- IRSA role trust policies must use the same namespace/service-account names provided to this module.
- Helm releases use atomic install/upgrade and wait for readiness, with a configurable timeout.

## Example

```hcl
module "eks_addons" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-addons?ref=v1.0.0"

  cluster_name       = module.eks.cluster_name
  aws_region         = var.aws_region
  vpc_id             = module.network.vpc_id
  domain_name        = var.domain_name
  lb_controller_role_arn = module.eks_irsa.lb_controller_role_arn
  external_dns_role_arn = module.eks_irsa.external_dns_role_arn

  # Set to tested, exact versions compatible with your EKS release.
  aws_load_balancer_controller_chart_version = var.aws_lb_controller_chart_version
  external_dns_chart_version                 = var.external_dns_chart_version
}
```

## Inputs and outputs

See [variables.tf](variables.tf) and [outputs.tf](outputs.tf). Both chart versions are required and validated as explicit semantic versions.
