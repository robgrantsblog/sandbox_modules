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

## Examples

Runnable Terraform root configurations demonstrating the published modules are under [examples/](examples/):

- [examples/vpc-example](examples/vpc-example/) — create an EKS-ready VPC with public and private subnets; no domain required.
- [examples/kms-example](examples/kms-example/) — create a customer-managed KMS key and alias for EKS Secrets encryption.
- [examples/eks-example](examples/eks-example/) — create an EKS cluster using existing VPC subnets and KMS key.
- [examples/irsa-example](examples/irsa-example/) — create IRSA roles for the AWS Load Balancer Controller and external-dns.
- [examples/dns-example](examples/dns-example/) — look up a public Route53 zone and request a DNS-validated ACM certificate.
- [examples/route53-example](examples/route53-example/) — look up an existing public or private Route53 hosted zone.
- [examples/example-waf](examples/example-waf/) — create a regional WAF web ACL; association with an ALB is separate.
- [examples/example-addons](examples/example-addons/) — install the AWS Load Balancer Controller and external-dns into an existing EKS cluster.

Each example README lists prerequisites and usage. Copy a `terraform.tfvars.example` where provided to the gitignored `terraform.tfvars`, then review `terraform plan` before applying. Examples that create resources may incur AWS charges.
