resource "aws_ecr_repository" "{{org_name}}-repo" {
  name                 = "{{org_name}}-${var.name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}