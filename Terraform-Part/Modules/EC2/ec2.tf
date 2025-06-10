# ----------------------------------------------------------------------------- #
# ------------------------------- EC2 Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "my_instance" {
  for_each = var.instances

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = each.value.instance_subnet_id
  private_ip                  = each.value.instance_private_ip
  associate_public_ip_address = each.value.has_public_ip
  vpc_security_group_ids      = each.value.security_group_ids
  # user_data                   = each.value.user_data
  iam_instance_profile        = each.value.instance_profile
  key_name                    = var.instance_key_pair
  # user_data_replace_on_change = true
  user_data = file("${path.module}/scripts/bastion.sh")
  tags = {
    Name       = each.key
    Deployment = "Terraform"
  }
}