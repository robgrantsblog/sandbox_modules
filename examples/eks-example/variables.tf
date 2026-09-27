variable "aws_region" {
  description = "AWS region in which to create the EKS cluster."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name for the EKS cluster."
  type        = string
  default     = "example-eks"
}

variable "cluster_version" {
  description = "Kubernetes minor version supported by EKS in the selected region."
  type        = string
  default     = "1.36"
}

variable "vpc_id" {
  description = "ID of an existing VPC for the cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "At least two existing private subnet IDs in distinct Availability Zones."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "Provide at least two private subnets in distinct Availability Zones."
  }
}

variable "kms_key_arn" {
  description = "ARN of an existing customer-managed KMS key for Kubernetes Secrets encryption."
  type        = string
}

variable "cluster_admin_role_arn" {
  description = "ARN of an existing IAM role that should receive EKS cluster-admin access."
  type        = string
}
