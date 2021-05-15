#!/bin/bash

# Run this file on the servers to install and configure:
# - apache2 
# - php
# - additional php modules
# - zip 
# Required: modify_dirindex file

# We can also set up virtual hosts and enable HTTPS

sudo apt update

echo "Adding a DNS..."
sudo sed -i '$ a nameserver 8.8.8.8' /etc/resolv.conf

echo "Installing apache2 server..."
sudo apt install apache2

echo "Installing and configuring php..."
sudo apt install php libapache2-mod-php php-mysql
sudo apt install php-mysql php-curl php-json php-gd php7.2-xml
sudo cp modify_dirindex /etc/apache2/mods-enabled/dir.conf 

sudo a2enmod rewrite expires
sudo systemctl restart apache2

# Zip is needed to download the Ampache app
echo "Installing zip ..."
sudo apt install zip 

# Enable transcoding of music and video files by installing FFmpeg
echo "Installing ffmpeg..."
sudo apt install ffmpeg

echo "Reloading apache2..."
sudo systemctl reload apache2.service

# DOWNLOAD AMPACHE 

# Download the zip archive for Ampache
echo "Downloading ampache 4.4.2 ... "
wget https://github.com/ampache/ampache/releases/download/4.4.2/ampache-4.4.2_all.zip

# Unzip into the amapche webserver directory
echo "Unzipping ampache ..."
sudo unzip ampache-4.4.2_all.zip -d /var/www/html/

# Set group
sudo chown --recursive www-data:www-data /var/www/html

# Rename .htaccess files that have security and other operation information
# .htaccess.dist > .htaccess 
echo "Renaming some files ..."
sudo mv /var/www/html/rest/.htaccess.dist /var/www/html/rest/.htaccess
sudo mv /var/www/html/play/.htaccess.dist /var/www/html/play/.htaccess
sudo mv /var/www/html/channel/.htaccess.dist /var/www/html/channel/.htaccess

echo "There are still some steps to go: see the end of this file." 
# When the installation is over, create the music directory 
# (also depending on where it will be stored)
# sudo mkdir -p /data/Music
# sudo chown www-data:www-data /data/Music 

# Another required step is to change the upload_max_filesize to 20MB
# and post_max_size to 30MB in /etc/php/7.2/apache2/php.ini
# Then also reload: sudo systemctl reload apache2.service

# Configure the webserver from http://ip_of_server 
# There may be some troubles with ampache.cfg.php file but 
# you'll manage to find a way! Indicate the IP addr of the database
# as host.


