#!/bin/bash
set -e

# Update package list and upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

# Enable universe repo (required for libonig5)
sudo add-apt-repository universe -y
sudo apt-get update -y

# Install dependencies
sudo apt-get install -y \
    git curl unzip jq vim wget net-tools \
    python3 python3-pip \
    ca-certificates apt-transport-https lsb-release gnupg \
    libonig5

# Clean up
sudo apt-get autoremove -y
sudo apt-get clean
