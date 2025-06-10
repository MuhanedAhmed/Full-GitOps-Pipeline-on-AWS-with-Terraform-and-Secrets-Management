# Get authentication token for the cluster
# data "aws_eks_cluster_auth" "cluster" {
#   name = var.cluster_name
# }

# Create additional namespaces if specified

# Create AWS credentials secret
resource "kubernetes_secret" "aws_secrets" {
  metadata {
    labels = {
      managed-by = "terraform"
      type       = "aws-credentials"
      name       = "aws-secrets-manager"
    }
  }

  type = "Opaque"
  
  data = {
    AWS_ACCESS_KEY_ID     = var.iam_user_access_key_id
    AWS_SECRET_ACCESS_KEY = var.iam_user_secret_access_key
  }
}