# ------------------------------------------------------------------------
# Creating EKS Access Entries for the cluster
# ------------------------------------------------------------------------

resource "aws_eks_access_entry" "gp_eks_access_entry" {
  cluster_name  = aws_eks_cluster.gp_eks_cluster.name
  principal_arn = var.gp_bastion_role_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "gp_eks_access_policy_association" {
  cluster_name  = aws_eks_cluster.gp_eks_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = var.gp_bastion_role_arn

  access_scope {
    type = "cluster"
  }
}