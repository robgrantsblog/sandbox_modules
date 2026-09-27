# Regional ALB WAF module example

This standalone Terraform root demonstrates using the published `alb-waf` module at `v1.0.0` to create a regional AWS WAFv2 web ACL. It enables AWS's Common Rule Set and Known Bad Inputs managed rule groups, CloudWatch metrics, and sampled requests. Resources are tagged `Environment = "example"` and `ManagedBy = "Terraform"`.

The web ACL is created in the configured AWS region, which must match the region of the ALB it will protect. **This example does not create or associate an ALB.** Use the `web_acl_arn` output in the ALB controller configuration or another caller-managed association; for an AWS Load Balancer Controller Ingress, set the `alb.ingress.kubernetes.io/wafv2-acl-arn` annotation to that ARN.

## Use

No `terraform.tfvars` file is required. The example defaults to `us-east-1` and names the web ACL `example-app-waf`. Override those with a local, gitignored `terraform.tfvars` if needed:

```hcl
aws_region      = "us-west-2"
application_name = "my-service"
```

Run from this directory:

```sh
terraform init
terraform plan
terraform apply
```

Review AWS WAF pricing and the plan before applying. The web ACL's default action is `allow`; matching managed rules use their AWS-defined actions. This example does not configure WAF logging or associate the ACL with traffic. When finished, review the `terraform destroy` plan before confirming.
