# ----------------------------------------------------------------------
# Creating a public route table and associate it with the public subnets
# ----------------------------------------------------------------------

resource "aws_route_table" "gp_public_routetable" {
  vpc_id = aws_vpc.gp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gp_igw.id
  }

  tags = {
    Name       = "gp_public_route_table"
    Deployment = "Terraform"
  }
}

resource "aws_route_table_association" "gp_public_subnet_routetable_association" {

  for_each = aws_subnet.gp_public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.gp_public_routetable.id
}

# ------------------------------------------------------------------------
# Creating a private route table and associate it with the private subnets
# ------------------------------------------------------------------------

resource "aws_route_table" "gp_private_routetable" {
  vpc_id = aws_vpc.gp_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gp_nat.id
  }

  tags = {
    Name       = "gp_private_route_table"
    Deployment = "Terraform"
  }
}

resource "aws_route_table_association" "gp_private_subnet_routetable_association" {

  for_each = aws_subnet.gp_private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.gp_private_routetable.id
}