# EKS add-ons module example

This standalone Terraform root demonstrates using the published `eks-addons` module at `v1.0.0` to install the AWS Load Balancer Controller and external-dns into an existing EKS cluster with Helm.

## Prerequisites

- Terraform >= 1.5, AWS CLI, and AWS credentials
- An existing EKS cluster, VPC, and working network connectivity from Terraform to the cluster API
- IRSA roles for both controllers, with trust policies matching the service accounts (`kube-system:aws-load-balancer-controller` and `kube-system:external-dns` by default)
- A domain filter covered by the external-dns role's Route53 permissions
- Explicit Helm chart versions compatible with the EKS/Kubernetes version

This example installs Kubernetes Helm releases; it does not create the cluster, VPC, IAM roles, Route53 zone, or an Ingress/ALB. Helm-managed Kubernetes resources are not AWS resources, so AWS resource tags do not apply here. For ALBs created later by the controller, set `alb.ingress.kubernetes.io/tags` on each Ingress.

## Configure and run

Copy the sample file and replace its placeholders with the actual EKS cluster details and role ARNs:

```sh
cp terraform.tfvars.example terraform.tfvars
```

Review both chart versions for compatibility and update them if needed. The sample pins AWS Load Balancer Controller chart `3.5.0` and external-dns chart `1.22.0`; the module requires exact versions and does not follow a floating `latest` tag.

Run from this directory:

```sh
terraform init
terraform plan
terraform apply
```

The Helm provider authenticates using `aws eks get-token`, so AWS CLI credentials must be valid and able to access the target cluster. The provider lockfile pins Helm provider `2.17.0`.

The module configures external-dns with an `upsert-only` policy and the supplied domain filter, so it creates/updates records but does not delete them. It installs the chart releases atomically and waits for readiness.
