# --------------------------------------------------------------------------
# Fetching AWS provider and setting the project backend to be remote on AWS
# --------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "2.37.1"
    # }
  }

  backend "s3" {
    bucket       = "gp-backend-bucket"
    key          = "states/graduation-project/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    profile      = "GraduationProject"
  }
}


# ---------------------------------------------------------------------
# Setting the configurations of AWS provider
# ---------------------------------------------------------------------

provider "aws" {
  region  = local.region
  profile = "GraduationProject"
}

# ---------------------------------------------------------------------
# Setting the configurations of Kubernetes provider
# ---------------------------------------------------------------------

# data "aws_eks_cluster_auth" "cluster" {
#   name       = module.eks_cluster.gp_eks_cluster_name
#   depends_on = [module.eks_cluster]
# }

# provider "kubernetes" {
#   host                   = module.eks_cluster.gp_eks_cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks_cluster.gp_eks_cluster_ca_certificate)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }