#!/bin/bash

# Update package index
sudo yum update -y

# Install Nginx
sudo amazon-linux-extras install nginx1.12 -y

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx service to start on boot
sudo systemctl enable nginx
