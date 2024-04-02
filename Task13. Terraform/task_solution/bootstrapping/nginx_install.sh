#!/usr/bin/env bash
sudo apt update && sudo apt upgrade -y && sudo apt install nginx -y
echo "<h1>Hello</h1>" > /var/www/html/index.nginx-debian.html