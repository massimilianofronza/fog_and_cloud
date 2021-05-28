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

# Look at the attached device 3
ls /dev/vd* 4
# create a filesystem on the whole volume 5
sudo mkfs.ext4 /dev/vdb 6
# create a mount point 7
sudo mkdir /mnt/disk1 8
# mount the disk 9
sudo mount /dev/vdb /mnt/disk1 10
# just a check if the filesystem was correctly created/mounted 11
df -h

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
- sudo echo "Creating database..."
  - sudo touch setup.sql 
  - sudo echo "CREATE DATABASE ampache_database;" | sudo tee setup.sql > /dev/null
  - sudo sed -i "$ a CREATE USER 'database_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';" setup.sql
  - sudo sed -i "$ a GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'localhost';" setup.sql
  - sudo sed -i "$ a CREATE USER 'database_user'@'172.24.4.0/255.255.255.0' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';" setup.sql
  - sudo sed -i "$ a GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'172.24.4.0/255.255.255.0';" setup.sql
  - sudo sed -i "$ a CREATE USER 'database_user'@'10.10.30.%' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';" setup.sql
  - sudo sed -i "$ a GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'10.10.30.%';" setup.sql
  - sudo mysql -u"root" -p"FCCpr0ject=" < setup.sql