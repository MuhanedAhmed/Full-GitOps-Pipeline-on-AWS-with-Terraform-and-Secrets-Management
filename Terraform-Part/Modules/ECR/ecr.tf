# ------------------------------------------------------------------------
# Creating ECR Repository
# ------------------------------------------------------------------------

resource "aws_ecr_repository" "gp_ecr_repository" {
  name = "gp_ecr_repository"

  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}