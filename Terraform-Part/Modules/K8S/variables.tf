variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  type        = string
}

variable "iam_user_access_key_id" {
  description = "The AWS IAM user access key ID"
  type        = string
  sensitive   = true
}

variable "iam_user_secret_access_key" {
  description = "The AWS IAM user secret access key"
  type        = string
  sensitive   = true
}
