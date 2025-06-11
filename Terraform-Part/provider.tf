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