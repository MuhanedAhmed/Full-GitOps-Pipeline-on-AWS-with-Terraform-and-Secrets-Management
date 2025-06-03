# ---------------------------------------------------------------------
# Creating a VPC and Internet Gateway
# ---------------------------------------------------------------------

resource "aws_vpc" "gp_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name       = var.vpc_name
    Deployment = "Terraform"
  }
}

resource "aws_internet_gateway" "gp_igw" {
  vpc_id = aws_vpc.gp_vpc.id

  tags = {
    Name       = "gp_igw"
    Deployment = "Terraform"
  }
}