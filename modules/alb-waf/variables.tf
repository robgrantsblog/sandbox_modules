variable "name" {
  description = "Name of the regional web ACL and its CloudWatch metric."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_-]{1,128}$", var.name))
    error_message = "name must be 1–128 characters and contain only letters, numbers, hyphens, or underscores."
  }
}

variable "description" {
  description = "Description of the web ACL."
  type        = string
  default     = "Baseline AWS managed-rule protection for an Application Load Balancer"

  validation {
    condition     = length(var.description) <= 256
    error_message = "description must be no longer than 256 characters."
  }
}

variable "tags" {
  description = "Tags to apply to the web ACL."
  type        = map(string)
  default     = {}
}
