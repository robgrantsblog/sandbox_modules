variable "cluster_name" {
  description = "EKS cluster name used to name the IAM roles."
  type        = string

  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 50
    error_message = "cluster_name must contain between 1 and 50 characters so the resulting IAM role names fit AWS limits."
  }
}

variable "eks_oidc_provider_arn" {
  description = "OIDC provider ARN exported by the EKS cluster module."
  type        = string
}

variable "route53_zone_arn" {
  description = "Route53 hosted-zone ARN to which the external-dns role is scoped."
  type        = string
}

variable "lb_controller_namespace_service_account" {
  description = "Namespace and service account identity trusted by the load balancer controller role, in namespace:name format."
  type        = string
  default     = "kube-system:aws-load-balancer-controller"
}

variable "external_dns_namespace_service_account" {
  description = "Namespace and service account identity trusted by the external-dns role, in namespace:name format."
  type        = string
  default     = "kube-system:external-dns"
}

variable "tags" {
  description = "Tags applied to the IAM roles and policies where supported by the upstream module."
  type        = map(string)
  default     = {}
}
