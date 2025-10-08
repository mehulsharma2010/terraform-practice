data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "ot-terraform-state-bucket2"
    key    = "infra/common/network/terraform.tfstate"
    region = "ap-south-1"
  }
}

terraform {
  backend "s3" {
    bucket       = "ot-terraform-state-bucket2"
    key          = "infra/env/mgmt/eks/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}

data "terraform_remote_state" "bastion" {
  backend = "s3"
  config = {
    bucket = "ot-terraform-state-bucket2"
    key    = "infra/common/bastion/terraform.tfstate"
    region = "ap-south-1"
  }
}