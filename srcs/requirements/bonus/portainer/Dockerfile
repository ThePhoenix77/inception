FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.3/portainer-2.21.3-linux-amd64.tar.gz \
    -o /tmp/portainer.tar.gz \
    && tar -xzf /tmp/portainer.tar.gz -C /opt \
    && rm /tmp/portainer.tar.gz

# 9443 = HTTPS
# 9000 = HTTP
EXPOSE 9443 9000 8000

CMD ["/opt/portainer/portainer"]
