# ------------------------------------------------------------------------
# Creating IAM Role for Service Account for Load Balancer Controller 
# ------------------------------------------------------------------------

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = file("${path.module}/LoadBalancerController-iam-policy.json")
}

data "aws_iam_policy_document" "lb_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.example.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:aws-lb-controller:aws-lb-controller-sa"]
    }
  }
}

resource "aws_iam_role" "lb_controller" {
  name               = "gp_lb_controller_role"
  assume_role_policy = data.aws_iam_policy_document.lb_controller_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lb_controller_attach" {
  role       = aws_iam_role.lb_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}

