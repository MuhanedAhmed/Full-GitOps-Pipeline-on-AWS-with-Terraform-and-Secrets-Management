# # --------------------------------------------------------------
# # Creating Secret for AWS IAM User 'read_secrets' in 'external-secrets' namespace
# # --------------------------------------------------------------

# # Create external-secrets namespace
# resource "kubernetes_namespace" "external_secrets_ns" {
#   metadata {
#     name = "external-secrets"
#     labels = {
#       managed-by = "terraform"
#     }
#   }
# }

# # Create AWS credentials secret
# resource "kubernetes_secret" "aws_secrets" {
#   metadata {
#     name      = "aws-secrets-manager"
#     namespace = kubernetes_namespace.external_secrets_ns.metadata[0].name
#     labels = {
#       managed-by = "terraform"
#       type       = "aws-credentials"
#     }
#   }

#   type = "Opaque"

#   data = {
#     AWS_ACCESS_KEY_ID     = var.iam_user_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.iam_user_secret_access_key
#   }
# }