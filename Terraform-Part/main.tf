# --------------------------------------------------------------
# Defining Global Values
# --------------------------------------------------------------

locals {
  region = "us-east-1"
}

# --------------------------------------------------------------
# Creating VPC
# --------------------------------------------------------------

module "main_vpc" {
  source   = "./Modules/VPC"
  vpc_cidr = "10.10.0.0/16"
  vpc_name = "gp_vpc"
  public_subnets = {
    public_subnet_1 = {
      subnet_az   = "${local.region}a"
      subnet_cidr = "10.10.10.0/24"
      tags = {
        "kubernetes.io/role/elb" = 1
      }
    }
    public_subnet_2 = {
      subnet_az   = "${local.region}b"
      subnet_cidr = "10.10.20.0/24"
      tags = {
        "kubernetes.io/role/elb" = 1
      }
    }
    public_subnet_3 = {
      subnet_az   = "${local.region}d"
      subnet_cidr = "10.10.30.0/24"
      tags = {
        "kubernetes.io/role/elb" = 1
      }
    }
  }
  private_subnets = {
    private_subnet_1 = {
      subnet_az   = "${local.region}a"
      subnet_cidr = "10.10.110.0/24"
      tags = {
        "kubernetes.io/role/internal-elb" = 1
      }
    }
    private_subnet_2 = {
      subnet_az   = "${local.region}b"
      subnet_cidr = "10.10.120.0/24"
      tags = {
        "kubernetes.io/role/internal-elb" = 1
      }
    }
    private_subnet_3 = {
      subnet_az   = "${local.region}d"
      subnet_cidr = "10.10.130.0/24"
      tags = {
        "kubernetes.io/role/internal-elb" = 1
      }
    }
  }
}

# --------------------------------------------------------------
# Creating Security Groups 
# --------------------------------------------------------------

module "security_groups" {
  source = "./Modules/Security Group"
  vpc_id = module.main_vpc.vpc_id
}

# --------------------------------------------------------------
# Creating IAM Roles 
# --------------------------------------------------------------

module "iam_roles" {
  source = "./Modules/IAM"
}

# --------------------------------------------------------------
# Creating EC2 Servers
# --------------------------------------------------------------

module "ec2_servers" {
  source            = "./Modules/EC2"
  instance_key_pair = "gp_keypair"
  instances = {
    bastion = {
      instance_subnet_id  = module.main_vpc.public_subnet_IDs["public_subnet_1"]
      instance_private_ip = "10.10.10.10"
      has_public_ip       = true
      security_group_ids  = [module.security_groups.gp_bastion_sg_id]
      instance_profile    = module.iam_roles.gp_bastion_instance_profile_name
    }
  }

  depends_on = [module.iam_roles]
}

# --------------------------------------------------------------
# Creating EKS Cluster
# --------------------------------------------------------------

module "eks_cluster" {
  source                     = "./Modules/EKS"
  gp_cluster_subnets_ids     = module.main_vpc.private_subnet_IDs
  gp_eks_cluster_role_arn    = module.iam_roles.gp_eks_cluster_role_arn
  gp_eks_node_group_role_arn = module.iam_roles.gp_eks_node_group_role_arn
  gp_bastion_role_arn        = module.iam_roles.gp_bastion_role_arn
  gp_bastion_sg_id           = module.security_groups.gp_bastion_sg_id
  gp_eks_cluster_sg_id       = module.security_groups.gp_eks_cluster_sg_id

  depends_on = [module.iam_roles]
}

# --------------------------------------------------------------
# Creating ECR Repository
# --------------------------------------------------------------

module "ecr_repo" {
  source = "./Modules/ECR"
}

# --------------------------------------------------------------
# Creating Secrets in AWS Secret Manager
# --------------------------------------------------------------

module "secrets_manager_secrets" {
  source            = "./Modules/Secrets Manager"
  database_username = "mongoodb"
  database_password = "password123"
}

# --------------------------------------------------------------
# Creating K8S Resources
# --------------------------------------------------------------

# Two-stage approach
resource "null_resource" "cluster_ready" {
  depends_on = [module.eks_cluster, module.iam_roles]

  provisioner "local-exec" {
    command = "echo 'Cluster ready'"
  }
}

module "k8s_secrets" {
  source      = "./Modules/K8S"
  github_user = var.github_user
  github_pass = var.github_pass

  depends_on = [null_resource.cluster_ready]
}