# ------------------------------------------------------------------------
# Creating EKS Addons
# ------------------------------------------------------------------------

resource "aws_eks_addon" "gp_kube-proxy" {
  cluster_name = aws_eks_cluster.gp_eks_cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "gp_vpc-cni" {
  cluster_name             = aws_eks_cluster.gp_eks_cluster.name
  addon_name               = "vpc-cni"
  service_account_role_arn = aws_iam_role.gp_vpc_cni_addon_role.arn
}

resource "aws_eks_addon" "gp_aws-ebs-csi-driver" {
  cluster_name             = aws_eks_cluster.gp_eks_cluster.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.gp_ebs_addon_role.arn
}

resource "aws_eks_addon" "gp_eks-node-monitoring-agent" {
  cluster_name = aws_eks_cluster.gp_eks_cluster.name
  addon_name   = "eks-node-monitoring-agent"
}

resource "aws_eks_addon" "gp_coredns" {
  cluster_name = aws_eks_cluster.gp_eks_cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "gp_eks-pod-identity-agent" {
  cluster_name = aws_eks_cluster.gp_eks_cluster.name
  addon_name   = "eks-pod-identity-agent"
}

resource "aws_eks_addon" "gp_metrics-server" {
  cluster_name = aws_eks_cluster.gp_eks_cluster.name
  addon_name   = "metrics-server"
}