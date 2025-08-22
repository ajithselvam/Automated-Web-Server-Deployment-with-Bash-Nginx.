#!/bin/bash
# Automated Web Server Deployment Script
# Tested on Ubuntu/Debian

set -e  # Exit immediately if a command fails

# Variables
GITHUB_REPO="https://github.com/your-username/sample-html-site.git"
WEBROOT="/var/www/html"
SERVICE="nginx"

echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing Nginx..."
sudo apt install -y nginx git

echo "Starting & enabling Nginx..."
sudo systemctl start $SERVICE
sudo systemctl enable $SERVICE

echo "Deploying site from GitHub repo..."
if [ -d "$WEBROOT" ]; then
    sudo rm -rf $WEBROOT/*
fi

sudo git clone $GITHUB_REPO $WEBROOT

echo "Setting permissions..."
sudo chown -R www-data:www-data $WEBROOT
sudo chmod -R 755 $WEBROOT

echo "Restarting Nginx..."
sudo systemctl restart $SERVICE

echo " Deployment complete!"
echo "Visit your server at: http://$(hostname -I | awk '{print $1}')"
