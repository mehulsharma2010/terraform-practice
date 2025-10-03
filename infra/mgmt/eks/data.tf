data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.bucket
    key    = var.network_bucket_key
    region = var.bucket_region
  }
}

