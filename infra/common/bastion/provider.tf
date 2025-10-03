terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.2"
    }
  }
}

provider "aws" {
  region = var.region
}
