# Automated-Web-Server-Deployment-with-Bash-Nginx.
Automated Web Server Deployment with Bash + Nginx.


This project will:

Install Nginx automatically

Deploy a sample HTML site from a GitHub repo

Configure systemd service to ensure Nginx runs at boot

Verify with curl http://localhost


Step 1: Create the Bash Script

Save this as deploy_webserver.sh:



#!/bin/bash
# Automated Web Server Deployment Script
# Tested on Ubuntu/Debian

set -e  # Exit immediately if a command fails

# Variables
GITHUB_REPO="https://github.com/your-username/sample-html-site.git"
WEBROOT="/var/www/html"
SERVICE="nginx"

echo " Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo " Installing Nginx..."
sudo apt install -y nginx git

echo " Starting & enabling Nginx..."
sudo systemctl start $SERVICE
sudo systemctl enable $SERVICE

echo " Deploying site from GitHub repo..."
if [ -d "$WEBROOT" ]; then
    sudo rm -rf $WEBROOT/*
fi

sudo git clone $GITHUB_REPO $WEBROOT

echo " Setting permissions..."
sudo chown -R www-data:www-data $WEBROOT
sudo chmod -R 755 $WEBROOT

echo " Restarting Nginx..."
sudo systemctl restart $SERVICE

echo " Deployment complete!"
echo "Visit your server at: http://$(hostname -I | awk '{print $1}')"




Step 2: Make It Executable

chmod +x deploy_webserver.sh

Step 3: Run the Script

./deploy_webserver.sh
This will install Nginx, fetch your GitHub repo, and deploy it.

Step 4: Verify Deployment
curl http://localhost


You should see your HTML content.
If running on a remote server, open in browser:

http://<your-server-ip>


optional
Nginx is already configured with systemd, but if you want to ensure auto-restart, you can add:
Systemd Service Auto-Restart

Add under [Service]:

Restart=always
RestartSec=5


reload using command
sudo systemctl daemon-reexec





