#!/bin/bash

# Update package index
sudo apt update
# sudo apt upgrade -y

# Install Nginx
sudo apt install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx service to start on boot
sudo systemctl enable nginx

# Add Node 20 Repo
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Install Node.js
sudo apt-get install -y nodejs

# Install Dependencies
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker Repository
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
sudo apt update
sudo apt -y install docker-ce

# Enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add Backend IP as Environment Variable:
echo "export VITE_BACKEND_URL='http://${backend-ip}:5000'" >> /etc/environment
