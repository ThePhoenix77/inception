FROM debian:bullseye

RUN apt update && apt install -y \
    php \
    php-fpm \
    php-mysql \
    php-redis \
    curl \
    tar \
    wget \
    unzip \
    netcat \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Download and extract WordPress
RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xvzf wordpress.tar.gz && \
    rm wordpress.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress

# Install WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php

# Config files
COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wp-config.php /var/www/html/wp-config.php

RUN chown -R www-data:www-data /var/www/html

# Entrypoint script
COPY ./tools/redis_entrypoint.sh /usr/local/bin/redis_entrypoint.sh
RUN chmod +x /usr/local/bin/redis_entrypoint.sh

EXPOSE 9000

# ENTRYPOINT ["/usr/local/bin/redis_entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
