variable "cluster_name" {
  description = "EKS cluster name used to name the VPC and tag its subnets for load-balancer discovery."
  type        = string

  validation {
    condition     = trimspace(var.cluster_name) != ""
    error_message = "cluster_name must not be empty."
  }
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC. Each AZ receives one public and one private subnet."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "availability_zone_count" {
  description = "Number of available AZs to use and corresponding public/private subnet pairs to create."
  type        = number
  default     = 3

  validation {
    condition     = var.availability_zone_count >= 1 && floor(var.availability_zone_count) == var.availability_zone_count
    error_message = "availability_zone_count must be a positive whole number."
  }
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateways for private subnet egress."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to share one NAT gateway across all AZs instead of creating one per AZ."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to VPC resources and subnets, in addition to the required EKS discovery tags."
  type        = map(string)
  default     = {}
}
