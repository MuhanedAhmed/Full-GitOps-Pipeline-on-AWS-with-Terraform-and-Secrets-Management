# ----------------------------------------------------------------------
# Creating IAM Role for the EKS Cluster Control Plane
# ----------------------------------------------------------------------

resource "aws_iam_role" "gp_eks_cluster_role" {
  name        = "gp_eks_cluster_role"
  description = "Allows the cluster Kubernetes control plane to manage AWS resources."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.gp_eks_cluster_role.name
}