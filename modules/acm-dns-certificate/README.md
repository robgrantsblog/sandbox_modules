# ACM DNS-validated certificate module

Creates an AWS Certificate Manager certificate, publishes its DNS validation records in an existing Route53 hosted zone, and waits for certificate validation to complete. The primary name and additional subject alternative names are configurable.

This is a reusable child module and does not configure an AWS provider or Terraform backend. Configure the AWS provider in the calling root; ACM certificates are regional, so select the region where the certificate will be consumed.

## Example

```hcl
module "acm_certificate" {
  source = "git::ssh://git@github.com/robgrantsblog/sandbox_modules.git//modules/acm-dns-certificate?ref=v1.0.0"

  domain_name               = "example.com"
  subject_alternative_names = ["*.example.com"]
  route53_zone_id           = "Z0123456789EXAMPLE"
}

output "certificate_arn" {
  value = module.acm_certificate.certificate_arn
}
```

Use a reviewed immutable Git tag in production. Ensure the hosted zone is authoritative for the certificate names and that the caller's AWS identity can manage the ACM certificate and Route53 records.

## Inputs

| Name | Required | Default | Description |
|---|---:|---|---|
| `domain_name` | Yes | — | Primary certificate domain name. |
| `route53_zone_id` | Yes | — | Public Route53 hosted-zone ID for validation. |
| `subject_alternative_names` | No | `[]` | Additional DNS names on the certificate, e.g. `*.example.com`. |
| `validation_record_ttl` | No | `60` | DNS validation record TTL in seconds. |
| `allow_overwrite` | No | `true` | Whether to allow overwriting existing validation records. |
| `tags` | No | `{}` | Tags applied to the ACM certificate. |

## Outputs

- `certificate_arn` — ARN of the DNS-validated certificate.
- `certificate_domain_name` — primary domain name on the certificate.
