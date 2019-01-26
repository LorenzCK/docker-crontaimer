FROM alpine:3.8
LABEL maintainer="Lorenz Cuno Klopfenstein <lck@klopfenstein.net>"

# Ensure cron runs in UTC timezone
ENV TZ=UTC

# Install bash, make, docker and docker compose
RUN apk update && \
    apk add --no-cache 'bash' && \
    apk add --no-cache 'make' && \
    apk add --no-cache 'docker>18' && \
    apk add --no-cache 'py-pip' && \
    pip --no-cache-dir install 'docker-compose==1.23.1'

COPY cronjobs /etc/crontabs/root

# Execute Cron daemon in foreground, log level 8
CMD ["crond", "-f", "-d", "8"]
