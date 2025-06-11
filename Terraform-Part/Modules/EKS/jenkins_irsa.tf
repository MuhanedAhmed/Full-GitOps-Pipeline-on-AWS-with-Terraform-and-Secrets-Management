data "aws_iam_policy_document" "jenkins_irsa_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:jenkins:kaniko-sa"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }
  }
}

resource "aws_iam_role" "jenkins_irsa_role" {
  name               = "eks-kaniko-role"
  assume_role_policy = data.aws_iam_policy_document.jenkins_irsa_assume_role.json
}

resource "aws_iam_policy" "jenkins_kaniko_ecr_policy" {
  name        = "jenkins-kaniko-ecr-policy"
  description = "ECR permissions for Jenkins Kaniko builds"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_irsa_custom_policy_attach" {
  role       = aws_iam_role.jenkins_irsa_role.name
  policy_arn = aws_iam_policy.jenkins_kaniko_ecr_policy.arn
}
