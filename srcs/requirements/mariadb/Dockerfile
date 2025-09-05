FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb_setup.sh /mariadb_setup.sh
RUN chmod +x /mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb_setup.sh"]
# CMD ["mysqld_safe"]

# MYSQL_DATABASE=wordpress
# MYSQL_USER=wp_user
# MYSQL_PASSWORD=wp_pass
# # MYSQL_SUPER=superuser42
# # MYSQL_SUPER_PASSWORD=superpassword
# MYSQL_ROOT_PASSWORD=rootpass