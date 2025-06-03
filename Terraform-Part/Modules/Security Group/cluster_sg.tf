# -----------------------------------------------------------------------------
# Creating eks cluster security group
# -----------------------------------------------------------------------------

resource "aws_security_group" "gp_eks_cluster_sg" {
  name        = "gp_eks_cluster_sg"
  description = "Allow traffic from the bastion host security group"
  vpc_id      = var.vpc_id

  tags = {
    Name       = "gp_eks_cluster_sg"
    Deployment = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "gp_allow_bastion_traffic" {
  security_group_id = aws_security_group.gp_eks_cluster_sg.id

  referenced_security_group_id = aws_security_group.gp_bastion_sg.id
  ip_protocol                  = "-1"
}