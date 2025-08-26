#!/bin/bash
set -e
chown -R 999:999 /var/lib/mysql
service mariadb start

sleep 6

mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS wordpress;

-- WordPress user
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

-- Administrator user (name must not contain "admin")
CREATE USER IF NOT EXISTS 'superuser'@'%' IDENTIFIED BY 'super_password';
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
EOF

service mariadb stop
exec mysqld_safe 
