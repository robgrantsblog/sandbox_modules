variable "aws_region" {
  description = "AWS provider region. Route53 hosted zones are global, but the provider requires a region."
  type        = string
  default     = "us-east-1"
}

variable "zone_name" {
  description = "DNS name of an existing Route53 hosted zone, such as example.com."
  type        = string
}

variable "private_zone" {
  description = "Whether to look up a private hosted zone instead of a public one."
  type        = bool
  default     = false
}
