locals {
  effective_alias_name  = var.alias_name == null ? "alias/${var.cluster_name}-eks-secrets" : var.alias_name
  effective_description = var.description == null ? "Envelope encryption key for ${var.cluster_name} Kubernetes secrets" : var.description
}

resource "aws_kms_key" "this" {
  description             = local.effective_description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy                  = var.key_policy
  tags                    = var.tags
}

resource "aws_kms_alias" "this" {
  name          = local.effective_alias_name
  target_key_id = aws_kms_key.this.key_id
}
