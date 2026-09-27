# Route53 hosted-zone lookup example

This standalone Terraform root demonstrates the published `route53-zone-lookup` module at `v1.0.0`. It looks up an existing hosted zone by its exact DNS name and outputs the zone ID and ARN. Set `private_zone = true` to look up a private hosted zone instead; the default is `false` for public zones.

This is a read-only lookup: it creates or changes no AWS resources, so resource tags are not applicable.

## Use

Copy the sample variables file and replace `example.com` with the exact name of a hosted zone in your AWS account:

```sh
cp terraform.tfvars.example terraform.tfvars
```

The real `terraform.tfvars` is gitignored. Then run from this directory:

```sh
terraform init
terraform plan
terraform apply
```

The AWS provider requires a region setting, but Route53 hosted zones are global. The example defaults to `us-east-1`; this does not change which zone is selected.
