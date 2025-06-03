# -----------------------------------------------------------------------------
# Creating bastion host security group
# -----------------------------------------------------------------------------

resource "aws_security_group" "gp_bastion_sg" {
  name        = "gp_bastion_sg"
  description = "Allow SSH traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name       = "gp_bastion_sg"
    Deployment = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "gp_ssh_rule_bastion" {
  security_group_id = aws_security_group.gp_bastion_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.gp_bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}