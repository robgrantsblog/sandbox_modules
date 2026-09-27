variable "aws_region" {
  description = "AWS region of the EKS cluster and its load balancers."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the existing EKS cluster."
  type        = string
}

variable "cluster_endpoint" {
  description = "API endpoint of the existing EKS cluster."
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate authority data for the EKS cluster."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC used by the AWS Load Balancer Controller."
  type        = string
}

variable "domain_name" {
  description = "Domain filter for external-dns; must be covered by the external-dns role's Route53 permissions."
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
  description = "Reviewed, exact AWS Load Balancer Controller Helm chart version."
  type        = string
}

variable "external_dns_chart_version" {
  description = "Reviewed, exact external-dns Helm chart version."
  type        = string
}
