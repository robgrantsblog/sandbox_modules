variable "aws_region" {
  description = "AWS region where the ALB and regional WAF web ACL will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "application_name" {
  description = "Application name used to name the web ACL."
  type        = string
  default     = "example-app"
}
