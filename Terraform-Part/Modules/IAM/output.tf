# -------------------------------------------------------------- #
# --------------------- IAM Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "gp_eks_cluster_role_arn" {
  description = "The ARN of the IAM role assigned to the EKS control plane"
  value       = aws_iam_role.gp_eks_cluster_role.arn
}

output "gp_eks_node_group_role_arn" {
  description = "The ARN of the IAM role associated with the EKS managed node group"
  value       = aws_iam_role.gp_eks_node_group_role.arn
}

output "gp_bastion_role_arn" {
  description = "The ARN of the IAM role assigned to the Bastion host"
  value       = aws_iam_role.gp_bastion_iam_role.arn
}

output "gp_bastion_instance_profile_name" {
  description = "The name of the instance profile assigned to the Bastion host"
  value       = aws_iam_instance_profile.gp_bastion_instance_profile.name
}

output "access_key_id" {
  value = aws_iam_access_key.read_secrets_user_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.read_secrets_user_key.secret
  sensitive = true
}
