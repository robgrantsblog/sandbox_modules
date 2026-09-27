# DNS-validated ACM certificate example

This standalone Terraform root demonstrates the `acm-dns-certificate` module together with `route53-zone-lookup`. It looks up an existing public Route53 hosted zone, requests an ACM certificate for the apex domain, creates its DNS validation record, and waits for validation. To add SANs, set `subject_alternative_names` in the module block.

The ACM certificate is tagged `Environment = "example"` and `ManagedBy = "Terraform"`. ACM certificates are regional, so choose the region where the consuming service (for example, an ALB) is deployed.

## Prerequisites

- Terraform >= 1.5
- AWS credentials with permission to request and describe ACM certificates and manage Route53 records in the hosted zone
- An existing public Route53 hosted zone whose name exactly matches `domain_name`

## Use

Copy the sample variables file to `terraform.tfvars`, then replace `example.com` with a domain that matches an existing public Route53 hosted zone:

```sh
cp terraform.tfvars.example terraform.tfvars
```

The real `terraform.tfvars` is gitignored, so it is intentionally not included in the example repository.

Then run from this directory:

```sh
terraform init
terraform plan
terraform apply
```

Terraform adds the ACM DNS validation CNAME records to the hosted zone and waits for ACM to validate the certificate. The example does not register a domain or create a hosted zone. Keep the validation records so ACM can renew the certificate automatically.

## Cost and cleanup

ACM public certificates are provided at no additional charge when used with integrated AWS services. Review the ACM pricing and your Route53 hosted-zone/query costs. Destroying the example removes the certificate and validation records managed by this configuration; review the destroy plan before confirming.
