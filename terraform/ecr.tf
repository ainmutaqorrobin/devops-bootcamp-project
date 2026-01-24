# ECR repository for container images
resource "aws_ecr_repository" "final_project" {
  name                 = "devops-bootcamp/final-project-robin"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "devops-bootcamp-ecr"
  }
}