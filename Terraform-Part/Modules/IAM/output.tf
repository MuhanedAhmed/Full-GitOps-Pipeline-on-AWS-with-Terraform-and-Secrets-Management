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
  value       = aws_iam_role.gp_bastion_role.arn
}

output "gp_bastion_role_name" {
  description = "The name of the IAM role assigned to the Bastion host"
  value       = aws_iam_role.gp_bastion_role.name
}