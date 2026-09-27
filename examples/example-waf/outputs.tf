output "web_acl_arn" {
  description = "ARN to reference when associating the web ACL with an ALB."
  value       = module.application_waf.web_acl_arn
}

output "web_acl_id" {
  description = "ID of the regional WAF web ACL."
  value       = module.application_waf.web_acl_id
}
