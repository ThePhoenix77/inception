FROM debian:bullseye

RUN apt update && apt install -y \
    php php-fpm php-mysql php-redis curl unzip netcat \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

WORKDIR /var/www/wordpress

#php runtime dir
RUN mkdir -p /run/php

#php-fpm pool config
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wordpress_entrypoint.sh /usr/local/bin/wordpress_entrypoint.sh
RUN chmod +x /usr/local/bin/wordpress_entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
