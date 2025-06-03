# ------------------------------------------------------------------------
# Creating EKS Data Plane
# ------------------------------------------------------------------------

resource "aws_eks_node_group" "gp_eks_node_group" {
  cluster_name = aws_eks_cluster.gp_eks_cluster.name

  node_group_name = "gp_eks_node_group"
  node_role_arn   = var.gp_eks_node_group_role_arn
  subnet_ids      = values(var.gp_cluster_subnets_ids)

  disk_size      = 20
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = "gp_keypair"
    source_security_group_ids = [var.gp_bastion_sg_id]
  }
}