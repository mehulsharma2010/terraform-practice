#!/bin/bash
set -e

TERRAFORM_VERSION="1.13.3"

wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
terraform -version

