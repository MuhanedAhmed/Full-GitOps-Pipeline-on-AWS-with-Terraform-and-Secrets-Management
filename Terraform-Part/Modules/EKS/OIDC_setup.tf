# ------------------------------------------------------------------------
# Creating OIDC provider for the cluster addons roles
# ------------------------------------------------------------------------

data "tls_certificate" "example" {
  url = aws_eks_cluster.gp_eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.gp_eks_cluster.identity[0].oidc[0].issuer
}
