FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY tools/mariadb_setup.sh /mariadb_setup.sh
RUN chmod +x /mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb_setup.sh"]