
CREATE DATABASE ampache_database; 
CREATE USER 'database_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';
GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'localhost';
