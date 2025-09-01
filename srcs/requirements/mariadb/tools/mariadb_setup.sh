#!/bin/bash
set -e

chmod 755 /run/mysqld
chmod 700 /var/lib/mysql

chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    mysqld_safe --datadir=/var/lib/mysql &
    pid="$!"

    #waiting for mariadb to be ready 
    echo "Waiting for MariaDB to start..."
    until mysqladmin ping --silent; do
        sleep 15
    done



#creating database and users
mysql -u root -p"$DB_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%' WITH GRANT OPTION;

    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
    CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL

mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown

fi

exec mysqld_safe --datadir=/var/lib/mysql