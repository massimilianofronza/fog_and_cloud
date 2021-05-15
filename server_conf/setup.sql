
CREATE DATABASE ampache_database; 
CREATE USER 'database_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';
GRANT ALL PRIVILEGES ON ampache_database.* TO 'database_user'@'localhost';

CREATE USER 'db_user'@'172.24.4.201' IDENTIFIED WITH mysql_native_password BY 'pr0jectDATA=base';
GRANT ALL PRIVILEGES ON ampache_database.* TO 'db_user'@'172.24.4.201';

