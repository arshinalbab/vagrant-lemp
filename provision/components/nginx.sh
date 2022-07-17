#!/bin/bash

apt-get update
apt-get install -y nginx

# Remove the default nginx file
rm -rf /var/www/html/index.nginx-debian.html

# Restart the nginx server
service nginx restart

# Copy the vhost config file for webserver
cp /var/www/provision/config/nginx/vhosts/dev.mytestproject.com /etc/nginx/sites-available/dev.mytestproject.com

# Copy the phpmyadmin.conf snippet
cp /var/www/provision/config/nginx/vhosts/snippets/phpmyadmin.conf /etc/nginx/snippets/phpmyadmin.conf

# Create the Symbolic link for the site
sudo ln -s  /etc/nginx/sites-available/dev.mytestproject.com /etc/nginx/sites-enabled/

# Restart the nginx for the changes to take effect
service nginx restart
