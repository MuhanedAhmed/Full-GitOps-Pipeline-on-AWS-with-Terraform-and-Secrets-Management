# ------------------------------------------------------------------------
# Creating IAM Role for Service Account for Argo Image Updater pod 
# ------------------------------------------------------------------------

data "aws_iam_policy_document" "argo_irsa_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:argocd:argocd-image-updater-sa"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }
  }
}

resource "aws_iam_role" "argo_irsa_role" {
  name               = "gp_argo_image_updater_role"
  assume_role_policy = data.aws_iam_policy_document.argo_irsa_assume_role.json
}

resource "aws_iam_policy" "argo_ecr_policy" {
  name        = "argo_ecr_policy"
  description = "ECR permissions for Argo Image Updater"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:ListImages"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "argo_irsa_custom_policy_attach" {
  role       = aws_iam_role.argo_irsa_role.name
  policy_arn = aws_iam_policy.argo_ecr_policy.arn
}
