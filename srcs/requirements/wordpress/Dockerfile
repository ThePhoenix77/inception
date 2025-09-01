FROM debian:bullseye

# Install PHP + required extensions + utilities
RUN apt-get update && apt-get install -y \
    php php-fpm php-mysql php-redis curl unzip netcat \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Create working directory
WORKDIR /var/www/wordpress

# Create PHP-FPM runtime directory
RUN mkdir -p /run/php

# Copy PHP-FPM pool config
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy entrypoint
COPY tools/wordpress_entrypoint.sh /usr/local/bin/wordpress_entrypoint.sh
RUN chmod +x /usr/local/bin/wordpress_entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
