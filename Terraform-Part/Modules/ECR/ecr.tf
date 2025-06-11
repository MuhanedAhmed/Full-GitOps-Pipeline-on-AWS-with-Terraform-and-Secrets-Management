# ------------------------------------------------------------------------
# Creating ECR Repository
# ------------------------------------------------------------------------

resource "aws_ecr_repository" "gp_ecr_frontend" {
  name = "frontend-app"

  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "gp_ecr_backend" {
  name = "backend-app"

  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}