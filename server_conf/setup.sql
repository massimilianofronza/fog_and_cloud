
CREATE DATABASE ampache_database; 
CREATE USER 'database_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';
GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'localhost';

CREATE USER 'database_user'@'172.24.4.0/255.255.255.0' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';
GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'172.24.4.0/255.255.255.0';

CREATE USER 'database_user'@'10.10.30.%' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';
GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'10.10.30.%';

