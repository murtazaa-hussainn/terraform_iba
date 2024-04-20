#!/bin/bash

# Update package index
sudo yum update -y

# Install Nginx
sudo yum install nginx -y

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx service to start on boot
sudo systemctl enable nginx
