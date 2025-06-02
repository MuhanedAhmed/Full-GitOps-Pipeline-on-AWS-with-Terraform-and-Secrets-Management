# -----------------------------------------------------------------------------
# Creating node group security group to allow SSH from bastion
# -----------------------------------------------------------------------------

resource "aws_security_group" "gp_node_group_sg" {
  name        = "gp_node_group_sg"
  description = "Allow SSH traffic from bastion host"
  vpc_id      = var.vpc_id

  tags = {
    Name       = "gp_node_group_sg"
    Deployment = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "gp_ssh_rule_node_group" {
  security_group_id = aws_security_group.gp_node_group_sg.id

  referenced_security_group_id = aws_security_group.gp_bastion_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.gp_node_group_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}