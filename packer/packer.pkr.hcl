packer {
  required_version = ">= 1.9.0"

  required_plugins {
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  default = "ap-south-1"
}

variable "ami_name" {
  default = "bastion-ubuntu-terraform"
}

source "amazon-ebs" "ubuntu" {
  region                  = var.region
  instance_type           = "t3.micro"
  ami_name                = "${var.ami_name}-${formatdate("YYYYMMDD-hhmmss", timestamp())}"
  ami_description         = "AMI for Bastion host with Terraform, AWS CLI, Helm, kubectl"
  ssh_username            = "ubuntu"
  associate_public_ip_address = true
  force_deregister        = true
  force_delete_snapshot   = true

  tags = {
    Name        = "bastion-builder"
    Environment = "shared"
    BuiltBy     = "packer"
  }

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
}

build {
  name    = "bastion-ami"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    script = "scripts/install_basics.sh"
  }

  provisioner "shell" {
    script = "scripts/install_terraform.sh"
  }

  provisioner "shell" {
    script = "scripts/install_k8s_tools.sh"
  }

  provisioner "shell" {
    script = "scripts/harden_ssh.sh"
  }

  post-processor "manifest" {
    output = "manifest.json"
  }
}
