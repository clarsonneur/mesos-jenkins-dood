FROM jenkins:latest

USER root

ARG DOCKER_VERSION

RUN wget -O /bin/docker.io  https://get.docker.io/builds/Linux/x86_64/docker-$DOCKER_VERSION && \
    chmod +x /bin/docker.io

RUN apt-get update && apt-get install -y sudo iproute2 && rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: /bin/docker.io" >> /etc/sudoers

COPY docker /usr/bin/docker

RUN curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose && chmod +x /usr/bin/docker-compose

USER jenkins
