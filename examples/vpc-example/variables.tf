variable "aws_region" {
  description = "AWS region in which to create the VPC."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name used to name the VPC and apply EKS subnet discovery tags."
  type        = string
  default     = "example-eks"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zone_count" {
  description = "Number of available AZs in which to create public/private subnet pairs."
  type        = number
  default     = 3
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateway(s) for private subnet egress."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to share one NAT gateway across the private subnets."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to VPC resources."
  type        = map(string)
  default = {
    Environment = "example"
    ManagedBy   = "Terraform"
  }
}
