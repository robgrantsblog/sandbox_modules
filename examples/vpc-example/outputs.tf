output "vpc_id" {
  description = "ID of the created VPC."
  value       = module.network.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs, suitable for EKS worker nodes."
  value       = module.network.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs, suitable for internet-facing load balancers."
  value       = module.network.public_subnet_ids
}
