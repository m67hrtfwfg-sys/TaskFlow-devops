resource "aws_ecr_repository" "taskflow" {
  name                 = "taskflow"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
