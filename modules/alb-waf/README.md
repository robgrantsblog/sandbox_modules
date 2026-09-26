# Regional ALB WAF module

Creates a regional AWS WAFv2 web ACL with AWS's Common Rule Set and Known Bad Inputs managed rule groups. The default action allows requests that are not blocked by those managed rules, and CloudWatch metrics and sampled requests are enabled. The returned ARN can be attached to an Application Load Balancer through its controller configuration or another caller-managed association.

This reusable child module does not configure an AWS provider or Terraform backend. Configure the AWS provider and state in the calling root, in the same region as the ALB.

## Example

```hcl
module "application_waf" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/alb-waf?ref=v1.0.0"

  name        = "production-app"
  description = "Managed-rule protection for the production application ALB"

  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

output "web_acl_arn" {
  value = module.application_waf.web_acl_arn
}
```

Use a reviewed immutable Git tag in production. Review managed-rule behavior and AWS WAF pricing; the default action is `allow`, and matching managed rules use their AWS-defined actions. This module creates the web ACL only; attaching it to an ALB is handled by the caller.

## Inputs

| Name | Required | Default | Description |
|---|---:|---|---|
| `name` | Yes | — | Web ACL name and CloudWatch metric name. |
| `description` | No | Baseline ALB managed-rule description | Web ACL description. |
| `tags` | No | `{}` | Tags applied to the web ACL. |

## Outputs

- `web_acl_arn` — ARN of the regional web ACL.
- `web_acl_id` — ID of the regional web ACL.
