# Docker CronTaimer

![Docker Hub pulls](https://img.shields.io/docker/pulls/lorenzck/crontaimer.svg)

Basic Docker image that executes cron jobs for you.

Lightweight image based on **Alpine:3.8** that runs the cron daemon in foreground.
Crontab file can be built into your image or mounted as a volume.

Docker, docker-compose, make and bash are included, allowing you to run scripts or interact with your containers in response to your cron jobs.

## Usage

The basic image includes a basic cron jobs file that prints out “Hello world!” every minute.
For instance:

```
~$ docker run --rm lorenzck/crontaimer
crond: crond (busybox 1.28.4) started, log level 8
Hello world!
crond: USER root pid   6 cmd echo "Hello world!"
```

Copy your crontab specification onto `/etc/crontabs/root` to set the jobs you need.
The simplest `Dockerfile` can be as follows:

```
FROM lorenzck/crontaimer:latest
COPY mycronjobs /etc/crontabs/root
```

A suggested docker-compose configuration might look like this:

```yml
version: '3'

services:
  timer:
    build: path-to-dockerfile
    volumes:
    - /var/run/docker.sock:/var/run/docker.sock:rw
    restart: unless-stopped
```

Mounting the Docker socket as a read/write volume allows you to operate on Docker containers from your cron jobs.

You may also choose to mount the directory containing your `docker-compose.yml` or `Makefile`, in order to use it from the `crontaimer` container to perform more complex tasks.
