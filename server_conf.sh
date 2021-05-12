# Before installing ampache, setup the server as in the guide
# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04

SERVER_IP=172.24.4.71
USER="georgiana"

ssh ubuntu@$SERVER_IP

sudo adduser $USER

# Interactively, set a password

# Grant admin privileges:
sudo usermod -aG sudo $USER

# Enable ssh for new user, only with the key pair: 
# Copy the authorized_keys file from ubuntu/.ssh/authorized_keys
# in the home folder of the new user: 
sudo rsync --archive --chown=$USER:$USER ~/.ssh /home/$USER
#Check that this worked by opening a new terminal on your machine and ssh-ing into it

# INSTALL LAMP
#https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04
sudo apt-get update
sudo sed -i '$ a nameserver 8.8.8.8' /etc/resolv.conf
sudo apt-get install apache2

# Access web page from own browser with an ssh tunneling: 
#ssh -L 8080:<server-ip-address>:80 georgiana.bud@$I_LAB -N
#browser: http://<server-ip-addressss:8080

# INSTALL AND CONFIGURE MYSQL
sudo apt install mysql-server
sudo mysql_secure_installation
# Password for root:  FCCpr0ject 

sudo mysql # MOSTLY interactive
SELECT user,authentication_string,plugin,host FROM mysql.user;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'FCCpr0ject=';
FLUSH PRIVILEGES;
exit

# INSTALL AND CONFIGURE PHP
sudo apt install php libapache2-mod-php php-mysql

#Move the PHP index file (highlighted above to the first position after the DirectoryIndex specification
# with the file modify_dirindex in the folder from which you execute this script:
sudo cp modify_dirindex /etc/apache2/mods-enabled/dir.conf 
sudo systemctl restart apache2

#We can also set up virtual hosts
