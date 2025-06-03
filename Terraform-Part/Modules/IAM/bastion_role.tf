# ----------------------------------------------------------------------
# Creating IAM Role for the Bastion Host
# ----------------------------------------------------------------------

resource "aws_iam_role" "gp_bastion_iam_role" {
  name        = "gp_bastion_role"
  description = "Allows the bastion host to access the EKS cluster."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "gp_bastion_instance_profile" {
  name = "gp_bastion_instance_profile"
  role = aws_iam_role.gp_bastion_iam_role.name
}

resource "aws_iam_policy" "gp_bastion_eks_policy" {
  name        = "gp_bastion_eks_policy"
  path        = "/"
  description = "A policy to allow eks operations from the bastion host"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "gp_bastion_eks_policy_attachment" {
  policy_arn = aws_iam_policy.gp_bastion_eks_policy.arn
  role       = aws_iam_role.gp_bastion_iam_role.name
}