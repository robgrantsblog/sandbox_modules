# EKS cluster module

Reusable Terraform child module for an Amazon EKS cluster and managed node group. It wraps [`terraform-aws-modules/eks/aws`](https://github.com/terraform-aws-modules/terraform-aws-eks) and expects networking and a customer-managed KMS key to be provisioned by the caller.

The module intentionally contains no provider configuration, backend, state, or credentials. The root configuration must configure the AWS provider and pass the required IDs/ARNs.

## Security defaults

- Kubernetes API endpoint is private-only by default. If public endpoint access is enabled, one or more trusted IPv4 CIDRs must be supplied; unrestricted `0.0.0.0/0` is not a recommended production setting.
- Cluster creator admin permissions default to `false`. Configure `access_entries` for named IAM roles/users; set creator admin only as an explicit convenience choice.
- Kubernetes Secrets use the caller-provided KMS key.
- EKS API, audit, authenticator, controller-manager, and scheduler logs are enabled, with 90-day CloudWatch retention by default.
- IRSA is enabled for workload IAM roles.

Ensure the private subnets have the necessary egress (for example, NAT or VPC endpoints) and that operators/CI can reach the private Kubernetes API endpoint.

## Example production use

Use a released Git tag for production rather than a local filesystem path:

```hcl
module "eks" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-cluster?ref=v1.0.0"

  cluster_name       = "production-app"
  cluster_version    = "1.36" # choose a version available in the deployment region
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  kms_key_arn        = module.kms.eks_secrets_key_arn

  access_entries = {
    platform_admin = {
      principal_arn = "arn:aws:iam::123456789012:role/platform-admin"
      policy_associations = {
        cluster_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  # Private-only API endpoint is the default. If public access is required,
  # set cluster_endpoint_public_access = true and restrict its CIDRs.
  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

Pin a reviewed module tag and commit the calling root's `.terraform.lock.hcl`. Review EKS version support, add-on compatibility, IAM access entries, network reachability, and the Terraform plan before applying. A control-plane version change does not automatically upgrade managed node groups; upgrade and validate nodes/add-ons as a separate step.

## Inputs

Required inputs are `cluster_name`, `vpc_id`, `private_subnet_ids`, and `kms_key_arn`. `access_entries` is required unless `enable_cluster_creator_admin_permissions = true`.

Optional inputs and defaults are declared in [variables.tf](variables.tf): cluster version `1.36`, private API access enabled, public access disabled, full control-plane logging with 90-day retention, and a small On-Demand managed node group. `managed_node_groups` can be set to configure multiple/custom managed node groups and overrides the single-node-group convenience inputs.

## Outputs

Exports cluster name, ARN, Kubernetes version and endpoint, CA data, control-plane security-group ID, and OIDC provider ARN/URL. See [outputs.tf](outputs.tf).
