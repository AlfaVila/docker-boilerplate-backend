CREATE USER IF NOT EXISTS myuser@'%' IDENTIFIED BY 'password';
SET PASSWORD FOR myuser@'%' = PASSWORD('password');
CREATE DATABASE IF NOT EXISTS mydb;
GRANT ALL ON mydb.* TO myuser@'%';

