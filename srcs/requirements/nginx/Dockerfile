FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/nginx_setup.sh /nginx_setup.sh
RUN chmod +x /nginx_setup.sh

COPY conf/site.html /var/www/html/site.html

EXPOSE 443

CMD ["/nginx_setup.sh"]
