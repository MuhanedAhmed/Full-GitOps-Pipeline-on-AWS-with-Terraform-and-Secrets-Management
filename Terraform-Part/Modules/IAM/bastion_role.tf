# ----------------------------------------------------------------------
# Creating IAM Role for the Bastion Host
# ----------------------------------------------------------------------

resource "aws_iam_role" "gp_bastion_iam_role" {
  name        = "gp_bastion_role"
  description = "Allows the bastion host to access the EKS cluster."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "gp_bastion_instance_profile" {
  name = "gp_bastion_instance_profile"
  role = aws_iam_role.gp_bastion_iam_role.name
}