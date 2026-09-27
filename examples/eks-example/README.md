# EKS cluster module example

This standalone Terraform root demonstrates using the published `eks-cluster` module at `v1.0.0` to create an EKS control plane and managed node group. It expects an existing VPC with at least two private subnets in distinct Availability Zones and an existing customer-managed KMS key. It does not create networking or the KMS key.

The example uses a private-only Kubernetes API endpoint (the module's secure default), an explicit EKS access entry for an existing IAM role, and `Environment = "example"` / `ManagedBy = "Terraform"` tags.

## Prerequisites

- Terraform >= 1.9
- AWS credentials with permissions to manage EKS, EC2, IAM, KMS integrations, and CloudWatch Logs
- An existing VPC, at least two private subnet IDs in different AZs, and a customer-managed KMS key ARN
- An existing IAM role ARN for the operator who should receive cluster-admin permissions
- Network access to the cluster's private API endpoint from Terraform and kubectl (for example, from within the VPC or through VPN)

## Configure and run

Create an untracked `terraform.tfvars` in this directory with your infrastructure IDs and IAM role ARN:

```hcl
vpc_id                = "vpc-0123456789abcdef0"
private_subnet_ids    = ["subnet-0123456789abcdef0", "subnet-0abcdef1234567890"]
kms_key_arn           = "arn:aws:kms:us-east-1:123456789012:key/11111111-2222-3333-4444-555555555555"
cluster_admin_role_arn = "arn:aws:iam::123456789012:role/eks-operators"
```

Then run these commands from this directory:

```sh
terraform init
terraform plan
terraform apply
```

The AWS region defaults to `us-east-1`, and the Kubernetes version defaults to `1.36`; adjust them to versions available in your selected region. Provider version is pinned to `5.100.0`, which is compatible with module `v1.0.0`.

After apply, use `terraform output -raw configure_kubectl` to get the AWS CLI command for updating kubeconfig. The endpoint is private, so kubectl must run from a network that can reach it.

## Cost and cleanup

EKS control planes, EC2 worker nodes, CloudWatch Logs, and the prerequisite KMS key incur charges. This example uses the module's default managed node group (two On-Demand `t3.medium` instances) and 90-day control-plane log retention. Review the plan and AWS pricing before applying. The KMS key is an input, so destroying this example's EKS stack does not delete the key.
