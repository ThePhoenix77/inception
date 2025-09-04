#!/bin/bash
set -e

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

if ! id -u ftpuser >/dev/null 2>&1; then
    useradd -m -d /var/www/wordpress -s /bin/bash ftpuser
    echo "ftpuser:ftppass" | chpasswd
fi

chown -R ftpuser:ftpuser /var/www/wordpress

exec /usr/sbin/vsftpd /etc/vsftpd.conf
