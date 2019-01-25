FROM alpine:3.8

# Install bash, make, docker and docker compose
RUN apk update && \
    apk add 'bash' && \
    apk add 'make' && \
    apk add 'docker>18' && \
    apk add 'py-pip' && \
    pip install 'docker-compose==1.23.1' && \
    rm -rf /var/cache/apk/*

COPY cronjobs /etc/crontabs/root

VOLUME [ "/etc/crontabs", "/var/run/docker.sock" ]

# Execute Cron daemon in foreground, log level 8
CMD ["crond", "-f", "-d", "8"]
