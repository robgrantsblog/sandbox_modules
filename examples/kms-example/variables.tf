variable "aws_region" {
  description = "AWS region in which to create the KMS key."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name used to build the key description and default alias."
  type        = string
  default     = "example-eks"
}
