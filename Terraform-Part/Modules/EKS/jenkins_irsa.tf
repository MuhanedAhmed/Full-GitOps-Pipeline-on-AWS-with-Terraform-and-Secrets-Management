data "aws_iam_policy_document" "jenkins_irsa_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:jenkins:jenkins-sa"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }
  }
}

resource "aws_iam_role" "jenkins_irsa_role" {
  name               = "jenkins-irsa-role"
  assume_role_policy = data.aws_iam_policy_document.jenkins_irsa_assume_role.json
}

resource "kubernetes_service_account" "jenkins_sa" {
  metadata {
    name      = "jenkins-sa"
    namespace = "jenkins" 
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.jenkins_irsa_role.arn
    }
  }
}

resource "aws_iam_role_policy_attachment" "jenkins_irsa_ecr_policy" {
  role       = aws_iam_role.jenkins_irsa_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
