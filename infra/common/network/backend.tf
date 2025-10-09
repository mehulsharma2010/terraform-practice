terraform {
  backend "s3" {
    bucket       = "ot-terraform-state-bucket"
    key          = "infra/common/network/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
