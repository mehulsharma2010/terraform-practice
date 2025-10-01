terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region

}

module "network" {
  source = "git::ssh://git@github.com/OT-CLOUD-KIT/terraform-aws-network-skeleton.git?ref=feature"

  vpc_cidr         = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  cluster_name     = var.cluster_name

  subnet_names = var.subnet_names
  subnet_cidrs = var.subnet_cidrs
  subnet_azs   = var.subnet_azs

  public_subnet_indexes = var.public_subnet_indexes
  create_nlb            = var.create_nlb
  create_alb            = var.create_alb

  bu      = var.bu
  program = var.program
  app     = var.app
  env     = var.env
  team    = var.team
  region  = var.region

  create_key_pair    = var.create_key_pair
  create_private_key = var.create_private_key
  key_pair_name      = var.key_pair_name
  public_key_path    = var.public_key_path

  create_route53 = var.create_route53
}

module "naming" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"
  bu       = var.bu
  env      = var.env
  app      = var.app
  tenant   = var.tenant
  resource = var.resource
}

