variable "aws_region" {
  description = "AWS region for the ACM certificate; use the same region as the service that will consume it."
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Apex domain name matching an existing public Route53 hosted zone, such as example.com."
  type        = string

  validation {
    condition     = trimspace(var.domain_name) != ""
    error_message = "domain_name must not be empty."
  }
}
