#!/bin/bash
set -e

# --- Wait for MariaDB before running wp-cli ---
echo "Waiting for MariaDB at ${DB_HOST:-mariadb:3306}..."
until nc -z -v -w30 ${DB_HOST:-mariadb} 3306
do
  echo "Waiting for database connection..."
  sleep 5
done
echo "MariaDB is up!"

# --- Redis plugin setup ---
if wp core is-installed --allow-root --path=/var/www/html; then
    echo "WordPress detected, ensuring Redis plugin is active..."
    if ! wp plugin is-installed redis-cache --allow-root --path=/var/www/html; then
        wp plugin install redis-cache --activate --allow-root --path=/var/www/html
    else
        wp plugin activate redis-cache --allow-root --path=/var/www/html
    fi
    wp redis enable --allow-root --path=/var/www/html || true
else
    echo "WordPress not yet installed, skipping Redis activation..."
fi

# --- Run the final command (php-fpm7.4 -F) ---
exec "$@"
