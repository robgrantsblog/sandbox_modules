variable "zone_name" {
  description = "DNS name of the Route53 hosted zone to look up."
  type        = string

  validation {
    condition     = trimspace(var.zone_name) != ""
    error_message = "zone_name must not be empty."
  }
}

variable "private_zone" {
  description = "Whether to look up a private hosted zone; false selects a public hosted zone."
  type        = bool
  default     = false
}
