# -------------------------------------------------------------- #
# ---------------------- SG Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "gp_bastion_sg_id" {
  value       = aws_security_group.gp_bastion_sg.id
  description = "The ID of the security group associated with the Bastion host"
}

output "gp_node_group_sg_id" {
  value       = aws_security_group.gp_node_group_sg.id
  description = "The ID of the security group attached to the EKS managed node group"
}