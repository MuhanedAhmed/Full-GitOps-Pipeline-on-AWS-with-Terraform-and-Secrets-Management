# ------------------------------------------------------------------------
# Creating EKS Control Plane
# ------------------------------------------------------------------------

resource "aws_eks_cluster" "gp_eks_cluster" {
  name = "gp_eks_cluster"

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = var.gp_eks_cluster_role_arn
  version  = "1.33"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    subnet_ids              = values(var.gp_cluster_subnets_ids)
  }
}