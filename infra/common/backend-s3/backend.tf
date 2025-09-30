terraform {
  backend "s3" {
    bucket       = "ot-terraform-state-bucket"
    key          = "backend-s3/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
