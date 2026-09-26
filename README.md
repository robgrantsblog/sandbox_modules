# sandbox_modules

Reusable Terraform modules maintained for sandbox and production projects.

## Modules

- [modules/acm-dns-certificate](modules/acm-dns-certificate/) — ACM certificate with Route53 DNS validation for a primary domain and optional SANs.
- [modules/eks-cluster](modules/eks-cluster/) — production-oriented EKS cluster module with private endpoint and explicit IAM access-entry defaults.
- [modules/eks-irsa](modules/eks-irsa/) — IAM Roles for Service Accounts for the AWS Load Balancer Controller and external-dns, scoped to an EKS OIDC provider and Route53 hosted zone.
- [modules/eks-secrets-kms](modules/eks-secrets-kms/) — customer-managed KMS key and alias for EKS Kubernetes Secret encryption.
- [modules/eks-addons](modules/eks-addons/) — version-pinned Helm deployments of AWS Load Balancer Controller and external-dns for an existing EKS cluster.
- [modules/route53-zone-lookup](modules/route53-zone-lookup/) — look up an existing public or private Route53 hosted zone by name.
- [modules/eks-vpc](modules/eks-vpc/) — VPC and EKS-discoverable public/private subnets across multiple Availability Zones.
- [modules/alb-waf](modules/alb-waf/) — regional WAFv2 web ACL with AWS Common Rule Set and Known Bad Inputs managed rules.

Use released Git tags from production root configurations; see each module's README for inputs, outputs, and deployment considerations.
