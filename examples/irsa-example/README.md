# EKS IRSA roles module example

This standalone Terraform root demonstrates the published `eks-irsa` module at `v1.0.0`. It creates two IAM roles: one trusted by the AWS Load Balancer Controller service account, and one trusted by external-dns. The external-dns permissions are scoped to the supplied Route53 hosted-zone ARN. Roles and policies receive `Environment = "example"` and `ManagedBy = "Terraform"` tags where supported.

## Prerequisites

- Terraform >= 1.5
- AWS credentials allowed to create IAM roles and policies and attach the required policies
- An existing EKS cluster with IRSA enabled and its IAM OIDC provider created
- The OIDC provider ARN and the ARN of the Route53 hosted zone external-dns should manage
- The corresponding Kubernetes service accounts must be named `kube-system:aws-load-balancer-controller` and `kube-system:external-dns`, unless the module inputs are customized

This example creates the IAM roles only. It does not create the EKS cluster, OIDC provider, Kubernetes service accounts, Route53 zone, or deploy the controllers.

## Configure and run

Copy the sample variables file and replace the example ARNs with values from your EKS cluster and Route53 zone:

```sh
cp terraform.tfvars.example terraform.tfvars
```

Then run from this directory:

```sh
terraform init
terraform plan
terraform apply
```

The AWS region defaults to `us-east-1`; change it to the cluster's region if needed. The resulting role ARNs are available as `lb_controller_role_arn` and `external_dns_role_arn`. Annotate the matching Kubernetes service accounts with those ARNs, or pass the outputs into the `eks-addons` module, which configures the annotations for you.

Review the plan and the upstream IAM policies before applying. The AWS Load Balancer Controller role has the upstream controller policy; external-dns has Route53 access scoped to the supplied hosted zone.
