# -------------------------------------------------------------- #
# -------------------- K8S Module Variables -------------------- #
# -------------------------------------------------------------- #

variable "github_user" {
  description = "Github username required for Argo Image Updater"
  type        = string
}

variable "github_pass" {
  description = "Github password required for Argo Image Updater"
  type        = string
  sensitive   = true
}