#!/bin/bash
set -e

chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

exec mysqld_safe --datadir=/var/lib/mysql