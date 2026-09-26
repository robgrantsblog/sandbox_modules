# EKS VPC module

Creates an AWS VPC with public and private subnets across available Availability Zones. It wraps `terraform-aws-modules/vpc/aws` and applies the subnet role and cluster-sharing tags that EKS and the AWS Load Balancer Controller use for subnet discovery.

This is a reusable child module and does not configure an AWS provider or Terraform backend. Configure the provider and state in the calling root.

## Example

```hcl
module "network" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/eks-vpc?ref=v1.0.0"

  cluster_name = "production-app"
  vpc_cidr     = "10.0.0.0/16"

  # Defaults use three AZs, one shared NAT gateway, and DNS hostnames.
  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

module "eks" {
  # ...
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
}
```

The default configuration creates one public and one private subnet per selected AZ and a single NAT gateway shared by private subnets. A single NAT gateway reduces cost but creates a cross-AZ dependency and is not as resilient as one gateway per AZ. Production callers can set `single_nat_gateway = false` for per-AZ NAT gateways, or disable NAT when private subnet egress is provided through other means.

Use a reviewed immutable Git tag in production. Review CIDR sizing, AZ count, routing, NAT availability, and the resulting plan before applying.

## Inputs

| Name | Required | Default | Description |
|---|---:|---|---|
| `cluster_name` | Yes | — | Cluster name for the VPC name and EKS subnet discovery tags. |
| `vpc_cidr` | No | `10.0.0.0/16` | IPv4 CIDR for the VPC. |
| `availability_zone_count` | No | `3` | Number of available AZs and public/private subnet pairs. |
| `enable_nat_gateway` | No | `true` | Whether to create NAT gateways. |
| `single_nat_gateway` | No | `true` | Share one NAT gateway instead of one per AZ. |
| `tags` | No | `{}` | Additional tags for VPC resources and subnets. |

## Outputs

- `vpc_id`
- `private_subnet_ids`
- `public_subnet_ids`
