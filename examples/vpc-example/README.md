# EKS VPC module example (no domain required)

This standalone Terraform root demonstrates using the published `eks-vpc` module. It creates a VPC, public and private subnets, and—by default—a single shared NAT gateway across three available Availability Zones. It does not create an EKS cluster, Route53 records, an ACM certificate, or any domain-related resources.

## Prerequisites

- Terraform >= 1.5
- AWS credentials configured for the AWS provider (for example, through an AWS profile or environment variables)
- Permissions to create VPC, subnet, route, internet gateway, NAT gateway, and Elastic IP resources

## Use

From this directory:

```sh
terraform init
terraform plan
terraform apply
```

The provider region defaults to `us-east-1`; adjust it with `terraform.tfvars` or `-var` if needed. To customize other inputs, create an untracked `terraform.tfvars` file, for example:

```hcl
aws_region             = "us-west-2"
cluster_name           = "my-eks-cluster"
vpc_cidr               = "10.20.0.0/16"
availability_zone_count = 3
single_nat_gateway     = true
```

After applying, Terraform outputs the VPC ID and public/private subnet IDs. The private subnet IDs can be supplied to an EKS cluster module separately. A domain is only needed later if you want DNS names or domain-based HTTPS ingress.

## Cost and cleanup

NAT gateways and their Elastic IPs incur ongoing charges, even if no application is deployed. Review the plan and AWS pricing before applying. When finished with this example, remove only resources created by this example by running `terraform destroy` from this directory and reviewing its plan before confirming.
