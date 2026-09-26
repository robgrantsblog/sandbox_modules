variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string

  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 100
    error_message = "cluster_name must contain between 1 and 100 characters."
  }
}

variable "cluster_version" {
  description = "Kubernetes minor version supported by Amazon EKS."
  type        = string
  default     = "1.36"

  validation {
    condition     = can(regex("^1\\.[0-9]+$", var.cluster_version))
    error_message = "cluster_version must be a Kubernetes minor version such as 1.36."
  }
}

variable "vpc_id" {
  description = "ID of the VPC in which to create the EKS cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "At least two private subnet IDs in distinct Availability Zones for the cluster and worker nodes."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "private_subnet_ids must contain at least two subnets."
  }
}

variable "control_plane_subnet_ids" {
  description = "Optional subnet IDs for EKS control-plane network interfaces; defaults to private_subnet_ids."
  type        = list(string)
  default     = null
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN used to encrypt Kubernetes Secrets."
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Whether the Kubernetes API endpoint is reachable from public IP addresses. Defaults to private-only access."
  type        = bool
  default     = false
}

variable "cluster_endpoint_private_access" {
  description = "Whether the Kubernetes API endpoint is reachable from within the VPC."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "IPv4 CIDRs allowed to reach the public Kubernetes API endpoint. Must be explicitly restricted when public access is enabled."
  type        = list(string)
  default     = []

  validation {
    condition     = !var.cluster_endpoint_public_access || length(var.cluster_endpoint_public_access_cidrs) > 0
    error_message = "Set trusted cluster_endpoint_public_access_cidrs when public endpoint access is enabled; do not leave the endpoint open to all IPs."
  }

  validation {
    condition     = alltrue([for cidr in var.cluster_endpoint_public_access_cidrs : can(cidrnetmask(cidr))])
    error_message = "cluster_endpoint_public_access_cidrs must contain valid IPv4 CIDR blocks."
  }
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Grant cluster-admin to the IAM principal running Terraform. Prefer explicit access_entries for production."
  type        = bool
  default     = false
}

variable "access_entries" {
  description = "EKS access entries for explicitly authorized IAM principals. Supply at least one entry unless creator admin permissions are enabled."
  type        = any
  default     = {}

  validation {
    condition     = var.enable_cluster_creator_admin_permissions || length(var.access_entries) > 0
    error_message = "Configure at least one access_entries principal, or explicitly enable creator admin permissions."
  }
}

variable "cluster_enabled_log_types" {
  description = "EKS control-plane log types delivered to CloudWatch Logs."
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Retention period in days for EKS control-plane logs."
  type        = number
  default     = 90
}

variable "node_group_name" {
  description = "Name/key of the EKS managed node group."
  type        = string
  default     = "default"
}

variable "managed_node_groups" {
  description = "Optional map of EKS managed node group definitions passed through to terraform-aws-modules/eks. When non-empty, this takes precedence over the single-group convenience settings below."
  type        = map(any)
  default     = {}
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed node group."
  type        = list(string)
  default     = ["t3.medium"]

  validation {
    condition     = length(var.node_instance_types) > 0
    error_message = "node_instance_types must contain at least one instance type."
  }
}

variable "node_capacity_type" {
  description = "Capacity type for the managed node group."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
  default     = 2

  validation {
    condition     = var.node_min_size <= var.node_desired_size && var.node_desired_size <= var.node_max_size
    error_message = "node_desired_size must be between node_min_size and node_max_size."
  }
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1

  validation {
    condition     = var.node_min_size >= 0
    error_message = "node_min_size must be non-negative."
  }
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3

  validation {
    condition     = var.node_max_size >= 0
    error_message = "node_max_size must be non-negative."
  }
}

variable "tags" {
  description = "Tags applied to EKS resources where supported by the upstream module."
  type        = map(string)
  default     = {}
}
