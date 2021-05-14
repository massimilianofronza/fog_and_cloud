# Log into te server as non root user, then create a folder for webserver
SERVER_IP=172.24.4.71
ssh ubuntu@$SERVER_IP

# STEP 2
# sudo mkdir /var/www/ampache

# Update and Install zip utility 
echo "Installing zip ..."
sudo apt update
sudo apt install zip 

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

# Create directory for data, outside ampache's document root, and give
# Ampache permissions to read and write
echo "Creating the music directory..."
sudo mkdir -p /data/Music
sudo chown www-data:www-data /data/Music

# Enable transcoding of music and video files by installing FFmpeg
echo "Installing ffmpeg..."
sudo apt install ffmpeg

#### PROBABLY HERE I NEED TO SET UP THE VIRTUAL HOSTS
#### and to ENABLE HTTPS (I think this is optional) 
#### BUT WE DON'T HAVE A DOMAIN

# Allow files bigger than 2MB
# open: sudo nano /etc/php/7.2/apache2/php.ini 
# change the following lines: 
# upload_max_filesize = 2M  to 20M 
# post_max_size = 25MB
echo "Reloading apache2..."
sudo systemctl reload apache2.service


# STEP 4 
# Create a MySQL server to store information such as preferences and
# user playlists

# Do it automatically: 
echo "Setting up the database..."
sudo mysql -u"root" -p"FCCpr0ject=" < setup.sql

# The previous step can be done manually:
# Open interactive mysql database: 
# mysql --user=root --password # type FCCpr0ject= when requested

# Create a db, a mysql user, grant privileges, check
# CREATE DATABASE ampache_database;
# CREATE USER 'database_user'@'localhost' IDENTIFIED BY 'pr0jectDATA!base';
# GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'localhost';

# check that the db exists: 
# mysql -u"database_user" -p"pr0jectDATA=base" 
# SHOW DATABASES; 

echo "Installation done."
echo "Please ensure that /var/www/html/config directory contains" 
echo "the ampache.cfg.php configuration file, and that the webserver has write permissions on it."
echo "Run: sudo chmod o+w /var/www/html/config/ampache.cfg.php"
echo "You are ready to configure the webserver from the web interface! http://IP"
# CONFIGURATION DONE! Via web interface
# /var/www/html/config has drwxr-xr-x permissions
# I want to give full write permissions to all because this way the config may work
# chmod o+w config
# chmod o+w ampache.cfg.php
# admin VeryVery53cur3