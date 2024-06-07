#!/bin/bash

# Go to Metabase folder
cd /home/ubuntu/metabase

# Pull the container images from docker-compose.yml file
sudo docker compose pull

# Start the metabase containers from docker-compose.yml file
sudo docker compose up