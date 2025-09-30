terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.3.1"

  region                                   = var.region
  bucket                                   = var.bucket
  for_each                                 = toset(var.bucket_names)
  type                                     = var.type
  object_ownership                         = var.object_ownership
  tags                                     = var.tags
  force_destroy                            = var.force_destroy
  versioning                               = var.versioning
  lifecycle_rule                           = var.lifecycle_rule
  cors_rule                                = var.cors_rule
  logging                                  = var.logging
  metric_configuration                     = var.metric_configuration
  intelligent_tiering                      = var.intelligent_tiering
  replication_configuration                = var.replication_configuration
  block_public_acls                        = var.block_public_acls
  restrict_public_buckets                  = var.restrict_public_buckets
  request_payer                            = var.request_payer
  block_public_policy                      = var.block_public_policy

}



