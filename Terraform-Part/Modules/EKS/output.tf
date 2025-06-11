# -------------------------------------------------------------- #
# --------------------- EKS Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "gp_eks_cluster_name" {
  description = "The name of the provisioned EKS cluster"
  value       = aws_eks_cluster.gp_eks_cluster.name
}
output "gp_eks_cluster_endpoint" {
  description = "The API server endpoint of the EKS cluster, used to interact with the Kubernetes control plane"
  value       = aws_eks_cluster.gp_eks_cluster.endpoint
}

output "gp_eks_cluster_ca_certificate" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.gp_eks_cluster.certificate_authority[0].data
}

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.gp_eks_cluster.id
}