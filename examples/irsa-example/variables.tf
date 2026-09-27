variable "aws_region" {
  description = "AWS region of the EKS cluster and IAM OIDC provider."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the existing EKS cluster; used to name the IAM roles."
  type        = string
  default     = "example-eks"

  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 50
    error_message = "cluster_name must contain between 1 and 50 characters."
  }
}

variable "eks_oidc_provider_arn" {
  description = "OIDC provider ARN for the existing EKS cluster."
  type        = string
}

variable "route53_zone_arn" {
  description = "ARN of the Route53 hosted zone external-dns is allowed to manage."
  type        = string
}
