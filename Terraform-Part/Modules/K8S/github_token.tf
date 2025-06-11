# --------------------------------------------------------------
# Creating Secret for Github Access Credentials
# --------------------------------------------------------------

resource "kubernetes_secret" "git_creds" {
  metadata {
    name      = "git-creds"
    namespace = "argocd"
  }

  data = {
    username = base64encode(var.github_user)
    password = base64encode(var.github_pass)
  }

  type = "Opaque"
}
