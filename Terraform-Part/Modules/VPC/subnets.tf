# ---------------------------------------------------------------------
# Creating public and private subnets
# ---------------------------------------------------------------------

resource "aws_subnet" "gp_public_subnets" {

  for_each = var.public_subnets

  vpc_id            = aws_vpc.gp_vpc.id
  cidr_block        = each.value.subnet_cidr
  availability_zone = each.value.subnet_az
  tags = merge({
    Name       = each.key
    Deployment = "Terraform"
  }, each.value.tags)
}

resource "aws_subnet" "gp_private_subnets" {

  for_each = var.private_subnets

  vpc_id            = aws_vpc.gp_vpc.id
  cidr_block        = each.value.subnet_cidr
  availability_zone = each.value.subnet_az
  tags = merge({
    Name       = each.key
    Deployment = "Terraform"
  }, each.value.tags)
}