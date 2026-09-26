variable "cluster_name" {
  description = "EKS cluster name used to construct the default key description and alias."
  type        = string
}

variable "description" {
  description = "Description recorded on the customer-managed KMS key."
  type        = string
  default     = null
}

variable "alias_name" {
  description = "Optional KMS alias name. Defaults to alias/<cluster_name>-eks-secrets."
  type        = string
  default     = null

  validation {
    condition     = var.alias_name == null || (startswith(var.alias_name, "alias/") && can(regex("^alias/[A-Za-z0-9/_-]+$", var.alias_name)) && !startswith(var.alias_name, "alias/aws/"))
    error_message = "alias_name must be a valid customer-managed KMS alias beginning with alias/ and must not use the reserved alias/aws/ prefix."
  }
}

variable "deletion_window_in_days" {
  description = "Waiting period before a scheduled KMS key deletion takes effect."
  type        = number
  default     = 30

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "deletion_window_in_days must be between 7 and 30."
  }
}

variable "enable_key_rotation" {
  description = "Whether automatic annual rotation is enabled for the KMS key."
  type        = bool
  default     = true
}

variable "key_policy" {
  description = "Optional JSON KMS key policy. If omitted, AWS applies its default account-root key policy."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the KMS key."
  type        = map(string)
  default     = {}
}
