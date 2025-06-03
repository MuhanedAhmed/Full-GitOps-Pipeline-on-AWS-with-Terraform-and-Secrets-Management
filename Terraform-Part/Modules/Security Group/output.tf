# -------------------------------------------------------------- #
# ---------------------- SG Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "gp_bastion_sg_id" {
  value       = aws_security_group.gp_bastion_sg.id
  description = "The ID of the security group associated with the Bastion host"
}

output "gp_eks_cluster_sg_id" {
  value       = aws_security_group.gp_eks_cluster_sg.id
  description = "The ID of the security group associated with the EKS cluster"
}