#!/bin/bash
set -e

# Wait for MariaDB
echo "Waiting for MariaDB at ${WORDPRESS_DB_HOST}..."
until nc -z -v -w30 "${WORDPRESS_DB_HOST%:*}" "${WORDPRESS_DB_HOST##*:}"; do
  echo "MariaDB not ready, retrying..."
  sleep 5
done
echo "MariaDB is up!"

# Download WordPress if not already present
if [ ! -f /var/www/wordpress/wp-settings.php ]; then
    echo "Downloading WordPress..."
    wp core download --path=/var/www/wordpress --allow-root
fi

cd /var/www/wordpress

chown -R www-data:www-data .
chmod -R 755 .

# Generate wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
    echo "Generating wp-config.php..."
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="${WP_SITE_URL:-https://tboussad.42.fr}" \
        --title="${WP_SITE_TITLE:-MySite}" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
    
    echo "Creating additional WordPress users..."
    wp user create "$WP_EDITOR_USER" "$WP_EDITOR_EMAIL" \
        --role=editor \
        --user_pass="$WP_EDITOR_PASSWORD" \
        --allow-root
fi

# -----------------------------
# ✅ Redis Configuration
# -----------------------------
echo "Configuring Redis..."
# Install & activate Redis plugin if not already
if ! wp plugin is-installed redis-cache --allow-root; then
    echo "Installing Redis plugin..."
    wp plugin install redis-cache --activate --allow-root
else
    echo "Activating Redis plugin..."
    wp plugin activate redis-cache --allow-root
fi

# Wait for Redis
until nc -z -v -w30 "redis" 6379; do
  echo "Redis not ready, retrying..."
  sleep 5
done
echo "Redis is up!"

# Add Redis configuration to wp-config.php
wp config set WP_REDIS_HOST "redis" --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp config set WP_CACHE true --raw --allow-root
wp config set WP_REDIS_DISABLED false --raw --allow-root

# Enable Redis caching
echo "Enabling Redis cache..."
wp redis enable --allow-root || true
wp redis status --allow-root

echo "Redis configuration complete!"
# -----------------------------

# Execute CMD passed to container
exec "$@"


# #!/bin/bash
# set -e

# # Wait for MariaDB
# echo "Waiting for MariaDB at ${WORDPRESS_DB_HOST}..."
# until nc -z -v -w30 "${WORDPRESS_DB_HOST%:*}" "${WORDPRESS_DB_HOST##*:}"; do
#   echo "MariaDB not ready, retrying..."
#   sleep 5
# done
# echo "MariaDB is up!"

# # Download WordPress if not already present
# if [ ! -f /var/www/wordpress/wp-settings.php ]; then
#     echo "Downloading WordPress..."
#     wp core download --path=/var/www/wordpress --allow-root
# fi

# cd /var/www/wordpress

# chown -R www-data:www-data .
# chmod -R 755 .

# # Generate wp-config.php if it doesn't exist
# if [ ! -f wp-config.php ]; then
#     echo "Generating wp-config.php..."
#     wp config create \
#         --dbname="$WORDPRESS_DB_NAME" \
#         --dbuser="$WORDPRESS_DB_USER" \
#         --dbpass="$WORDPRESS_DB_PASSWORD" \
#         --dbhost="$WORDPRESS_DB_HOST" \
#         --allow-root
# fi

# # Install WordPress if not already installed
# if ! wp core is-installed --allow-root; then
#     echo "Installing WordPress..."
#     wp core install \
#         --url="${WP_SITE_URL:-https://tboussad.42.fr}" \
#         --title="${WP_SITE_TITLE:-MySite}" \
#         --admin_user="$WP_ADMIN_USER" \
#         --admin_password="$WP_ADMIN_PASSWORD" \
#         --admin_email="$WP_ADMIN_EMAIL" \
#         --skip-email \
#         --allow-root
    
#     echo "Creating additional WordPress users..."
#     wp user create "$WP_EDITOR_USER" "$WP_EDITOR_EMAIL" \
#         --role=editor \
#         --user_pass="$WP_EDITOR_PASSWORD" \
#         --allow-root
    
# fi

# # Redis config
# # wp config set WP_REDIS_HOST redis --allow-root
# # wp config set WP_REDIS_PORT 6379 --raw --allow-root

# # Install & activate Redis plugin if not already
# if ! wp plugin is-installed redis-cache --allow-root; then
#     wp plugin install redis-cache --activate --allow-root
# else
#     wp plugin activate redis-cache --allow-root
# fi

# wp redis enable --allow-root || true

# #executing the CMD passed to container
# exec "$@"
