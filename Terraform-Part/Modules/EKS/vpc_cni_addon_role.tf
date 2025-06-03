# ----------------------------------------------------------------------
# Creating IAM Role for the VPC CNI addon
# ----------------------------------------------------------------------

data "aws_iam_policy_document" "gp_vpc_cni_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }
  }
}

resource "aws_iam_role" "gp_vpc_cni_addon_role" {
  name               = "gp_vpc_cni_addon_role"
  assume_role_policy = data.aws_iam_policy_document.gp_vpc_cni_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "gp_vpc_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.gp_vpc_cni_addon_role.name
}