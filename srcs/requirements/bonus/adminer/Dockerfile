FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-mysqli \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer
WORKDIR /var/www/adminer

RUN curl -L -o index.php https://www.adminer.org/latest.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]
