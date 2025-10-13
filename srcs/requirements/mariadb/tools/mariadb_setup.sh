#!/bin/bash
set -e

# -------------------------------
# setting permissions
# -------------------------------
chmod 755 /run/mysqld
chmod 700 /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# -------------------------------
# initializing MariaDB if empty
# -------------------------------
if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB in the background
    mysqld_safe --datadir=/var/lib/mysql &
    pid="$!"

    echo "Waiting for MariaDB to start..."
    until mysqladmin ping --silent; do
        sleep 5
    done

    echo "Creating database and users..."

    mysql -u root <<-EOSQL
        -- Create WordPress database
        CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;

        -- WordPress user (any host)
        CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
        GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';

        -- Super/administrator user (any host)
        CREATE USER IF NOT EXISTS '$DB_SUPER'@'%' IDENTIFIED BY '$DB_SUPER_PASSWORD';
        GRANT ALL PRIVILEGES ON *.* TO '$DB_SUPER'@'%' WITH GRANT OPTION;

        -- Apply privileges immediately
        FLUSH PRIVILEGES;
EOSQL

    echo "Shutting down temporary MariaDB..."
    mysqladmin -u root shutdown
fi

# -------------------------------
# Start MariaDB in foreground
# -------------------------------
exec mysqld_safe --datadir=/var/lib/mysql
