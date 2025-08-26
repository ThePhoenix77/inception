FROM debian:bullseye

RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    curl \
    tar \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xvzf wordpress.tar.gz && \
    rm wordpress.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress

RUN mkdir -p /run/php
COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wp-config.php /var/www/html/wp-config.php

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]