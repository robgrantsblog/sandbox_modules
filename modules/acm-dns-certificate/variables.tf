variable "domain_name" {
  description = "Primary domain name for the ACM certificate."
  type        = string

  validation {
    condition     = trimspace(var.domain_name) != ""
    error_message = "domain_name must not be empty."
  }
}

variable "route53_zone_id" {
  description = "ID of the public Route53 hosted zone used for DNS validation records."
  type        = string

  validation {
    condition     = trimspace(var.route53_zone_id) != ""
    error_message = "route53_zone_id must not be empty."
  }
}

variable "subject_alternative_names" {
  description = "Additional DNS names to include on the certificate, such as *.example.com."
  type        = list(string)
  default     = []
}

variable "validation_record_ttl" {
  description = "TTL in seconds for Route53 DNS validation records."
  type        = number
  default     = 60

  validation {
    condition     = var.validation_record_ttl > 0
    error_message = "validation_record_ttl must be greater than zero."
  }
}

variable "allow_overwrite" {
  description = "Whether to allow Terraform to overwrite existing Route53 validation records."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the ACM certificate."
  type        = map(string)
  default     = {}
}
