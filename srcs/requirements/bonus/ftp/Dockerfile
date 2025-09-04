FROM debian:bullseye

RUN apt update && apt install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp_setup.sh /usr/local/bin/ftp_setup.sh
RUN chmod +x /usr/local/bin/ftp_setup.sh

EXPOSE 21 21100-21110

CMD ["/usr/local/bin/ftp_setup.sh"]
