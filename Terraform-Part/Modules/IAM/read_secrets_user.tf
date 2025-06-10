resource "aws_iam_user" "read_secrets_user" {
  name = "read-secrets-user"
}

resource "aws_iam_access_key" "read_secrets_user_key" {
  user = aws_iam_user.read_secrets_user.name
}

resource "aws_iam_policy" "secrets_read_policy" {
  name = "SecretsReadPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.read_secrets_user.name
  policy_arn = aws_iam_policy.secrets_read_policy.arn
}