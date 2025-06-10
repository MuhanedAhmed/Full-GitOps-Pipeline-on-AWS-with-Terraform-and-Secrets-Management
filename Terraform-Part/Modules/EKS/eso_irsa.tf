data "aws_iam_policy_document" "eso_irsa_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:external-secrets:external-secrets-sa"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }
  }
}

resource "aws_iam_role" "eso_irsa_role" {
  name               = "eks-eso-role"
  assume_role_policy = data.aws_iam_policy_document.eso_irsa_assume_role.json
}

resource "aws_iam_policy" "eso_secrets_manager_policy" {
  name        = "eso-secrets-manager-policy"
  description = "Secrets Manager permissions for External Secrets Operator"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:ListSecrets",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eso_irsa_custom_policy_attach" {
  role       = aws_iam_role.eso_irsa_role.name
  policy_arn = aws_iam_policy.eso_secrets_manager_policy.arn
}
