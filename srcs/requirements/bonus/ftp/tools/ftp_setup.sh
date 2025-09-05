#!/bin/bash
set -e

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

if ! id -u $FTPUSER >/dev/null 2>&1; then
    useradd -m -d /var/www/wordpress -s /bin/bash $FTPUSER
    echo "$FTPUSER:$FTPPASS" | chpasswd
fi

chown -R $FTPUSER:$FTPUSER /var/www/wordpress

exec /usr/sbin/vsftpd /etc/vsftpd.conf
