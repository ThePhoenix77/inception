FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf
COPY tools/mariadb_setup.sh  mariadb_setup.sh 

RUN chmod +x /mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb_setup.sh"]