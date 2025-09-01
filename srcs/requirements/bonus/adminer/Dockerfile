FROM debian:bullseye

# Install PHP and required extensions
RUN apt-get update && apt-get install -y \
    php \
    php-mysqli \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create working directory for Adminer
RUN mkdir -p /var/www/adminer
WORKDIR /var/www/adminer

# Download the latest Adminer PHP file
RUN curl -L -o index.php https://www.adminer.org/latest.php

# Expose Adminer port
EXPOSE 8080

# Run Adminer with PHP’s built-in server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]
