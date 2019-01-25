# Docker CronTaimer

![Docker Hub pulls](https://img.shields.io/docker/pulls/lorenzck/crontaimer.svg)

Basic Docker image that executes cron jobs for you.

Lightweight image based on **Alpine:3.8** that runs the cron daemon in foreground.
Crontab file can be built into your image or mounted as a volume.

Docker, docker-compose, make and bash are included, allowing you to run scripts or interact with your containers in response from your cron jobs.

## Usage

The basic image includes a basic cron jobs file that prints out “Hello world!” every minute.
For instance:

```
~$ docker run --rm lorenzck/crontaimer
crond: crond (busybox 1.28.4) started, log level 8
Hello world!
crond: USER root pid   6 cmd echo "Hello world!"
```

When using the image as a service in docker-compose, mount your own cron jobs specification using a volume.

```yml
version: '3'

services:
  timer:
    image: lorenzck/crontaimer:latest
    volumes:
    - ./mycronjobs:/etc/crontabs/root:ro
    - /var/run/docker.sock:/var/run/docker.sock:rw
    restart: unless-stopped
```

Mounting the Docker socket as a read/write volume also allows you to operate on Docker containers from your cron jobs.

You may also choose to mount your `docker-compose.yml` or `Makefile` in order to use it from the `crontaimer` container and perform more complex tasks.
