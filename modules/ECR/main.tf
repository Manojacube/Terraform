resource "aws_ecr_repository" "noonum_registry" {
  name                 = var.ecr_registry_name
  image_tag_mutability = "MUTABLE"
  force_delete = true
}