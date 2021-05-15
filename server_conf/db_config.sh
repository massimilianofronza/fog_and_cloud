#!/bin/bash 

# Run this script to install and configure the database.
# Required: setup.sql file

# When the setup is over, you also need to allow remote
# connections, in  /etc/mysql/mysql.conf.d/mysqld.cnf
# bind-address 0.0.0.0 (or the IPs of the servers) 
# sudo systemctl restart mysql

sudo apt update
echo "Adding a DNS..."
sudo sed -i '$ a nameserver 8.8.8.8' /etc/resolv.conf

echo "Installing mysql-server"
sudo apt install mysql-server
sudo mysql_secure_installation # Requires user interaction

# Update root mysql password
debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password FCCpr0ject='
debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password FCCpr0ject='

# Create a MySQL server to store user information; database is 
# accessible remotely by users of specified IPs (see setup.sql) 
echo "Setting up the database..."
sudo mysql -u"root" -p"FCCpr0ject=" < setup.sql

# The above can be done manually: 
#sudo mysql 
#SELECT user,authentication_string,plugin,host FROM mysql.user;
#ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'FCCpr0ject=';
#FLUSH PRIVILEGES;
#exit;

# The previous step can be done manually:
# mysql --user=root --password # type FCCpr0ject= when requested
# CREATE DATABASE ampache_database;
# CREATE USER 'database_user'@'localhost' IDENTIFIED BY 'pr0jectDATA!base';
# GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'localhost';
# exit;
# check that the db exists: 
# mysql -u"database_user" -p"pr0jectDATA=base" 
# SHOW DATABASES; 