variable "cluster_name" {
  description = "EKS cluster name passed to the AWS Load Balancer Controller and external-dns."
  type        = string
}

variable "aws_region" {
  description = "AWS region in which the EKS cluster and its load balancers are deployed."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID used by the AWS Load Balancer Controller for subnet and security group discovery."
  type        = string
}

variable "domain_name" {
  description = "DNS domain that external-dns is allowed to manage."
  type        = string
}

variable "lb_controller_role_arn" {
  description = "IRSA role ARN for the AWS Load Balancer Controller service account."
  type        = string
}

variable "external_dns_role_arn" {
  description = "IRSA role ARN for the external-dns service account."
  type        = string
}

variable "aws_load_balancer_controller_chart_version" {
  description = "Explicit AWS Load Balancer Controller Helm chart version. Choose and review a supported chart version before use."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+([+-][0-9A-Za-z.-]+)?$", var.aws_load_balancer_controller_chart_version))
    error_message = "Specify an explicit semantic chart version, not latest or a floating range."
  }
}

variable "external_dns_chart_version" {
  description = "Explicit external-dns Helm chart version. Choose and review a supported chart version before use."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+([+-][0-9A-Za-z.-]+)?$", var.external_dns_chart_version))
    error_message = "Specify an explicit semantic chart version, not latest or a floating range."
  }
}

variable "namespace" {
  description = "Kubernetes namespace for the controller releases."
  type        = string
  default     = "kube-system"
}

variable "aws_load_balancer_controller_service_account_name" {
  description = "Kubernetes service-account name for the AWS Load Balancer Controller. Must match the IRSA trust policy."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "external_dns_service_account_name" {
  description = "Kubernetes service-account name for external-dns. Must match the IRSA trust policy."
  type        = string
  default     = "external-dns"
}

variable "helm_timeout_seconds" {
  description = "Timeout for Helm release operations."
  type        = number
  default     = 600

  validation {
    condition     = var.helm_timeout_seconds >= 60
    error_message = "helm_timeout_seconds must be at least 60 seconds."
  }
}
