# ------------------------------------------------------------------------
# Creating Elastic IP and NAT Gateway
# ------------------------------------------------------------------------

resource "aws_eip" "gp_nat_eip" {
  domain = "vpc"
  tags = {
    Name       = "gp_nat_eip"
    Deployment = "Terraform"
  }
}

resource "aws_nat_gateway" "gp_nat" {
  allocation_id = aws_eip.gp_nat_eip.id
  subnet_id     = aws_subnet.gp_public_subnets["public_subnet_1"].id

  tags = {
    Name       = "gp_nat"
    Deployment = "Terraform"
  }
}