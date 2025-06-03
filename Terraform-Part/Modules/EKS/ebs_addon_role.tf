# ----------------------------------------------------------------------
# Creating IAM Role for the EBS addon
# ----------------------------------------------------------------------

data "aws_iam_policy_document" "gp_ebs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }
  }
}

resource "aws_iam_role" "gp_ebs_addon_role" {
  name               = "gp_ebs_addon_role"
  assume_role_policy = data.aws_iam_policy_document.gp_ebs_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "gp_ebs_addon_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.gp_ebs_addon_role.name
}