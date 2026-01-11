terraform {
  backend "s3" {
    bucket  = "devops-bootcamp-terraform-robin"
    key     = "devops-bootcamp/terraform.tfstate"
    region  = "ap-southeast-1"
  }
}
