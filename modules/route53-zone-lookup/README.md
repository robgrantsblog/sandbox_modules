# Route53 hosted-zone lookup module

Looks up an existing Route53 hosted zone by DNS name and exposes its ID and ARN. By default, it selects a public hosted zone; set `private_zone = true` to select a private hosted zone instead.

This is a reusable child module and does not configure an AWS provider or Terraform backend. Configure the AWS provider and state in the calling root.

## Example

```hcl
module "dns_zone" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/route53-zone-lookup?ref=v1.0.0"

  zone_name    = "example.com"
  private_zone = false
}

output "route53_zone_id" {
  value = module.dns_zone.zone_id
}
```

Use a reviewed immutable Git tag in production. The zone name must exactly identify an existing hosted zone of the selected visibility.

## Inputs

| Name | Required | Default | Description |
|---|---:|---|---|
| `zone_name` | Yes | — | DNS name of the hosted zone to look up. |
| `private_zone` | No | `false` | Whether to select a private hosted zone. |

## Outputs

- `zone_id` — ID of the matched hosted zone.
- `zone_arn` — ARN of the matched hosted zone.
