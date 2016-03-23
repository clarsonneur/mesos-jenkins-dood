# Introduction

This image is used by a jenkins slave through mesos. It contains few things:

- docker (By default 1.9.1)

  It requires that the host uses a version compatible to the latest one installed in this image.

  NOTE: We may decide to use the host docker binary instead.

- docker-compose (latest version)

# How to use it?
 
This image is used by jenkins to start a jenkins slave from docker. It was tested with jenkins connected to a Mesos cluster 1.24.1. But it should work without issue by any kind of jenkins master implementation.


It uses Dood implementation (Docker out of docker) in order to use the host docker instance.
So, you need to mount the local socket, usually /var/run/docker.sock

Ex: 
    
    $ docker run -v /var/run/docker.sock:/var/run/docker.sock ...

If you are using Mesos jenkins plugins, you should declare to mount this docker socket.

By default, the latest version of docker binary is already available. but you can decide to use the host docker binary instead.
It will ensure that you are using the same version between the host and your container version.

Ex: 

    $ docker run -v /var/run/docker.sock:/var/run/docker.sock -v {Host docker binary}:/usr/bin/docker.io ...

WANRING! This binary mount will work fine is the binary is build statically.

# How to build and publish this image?

1. Then build it and tag it with <host>[:port]/<repo>/jenkins-slave-dood

    $ bin/build.sh MyRepo

MyRepo is formatted as [registry[:port]/]RepoName
By default it will push to hub.docker.com under your name (as soon as your are already connected.)
You can specify different registry to publish to your own private one for example.

NOTE: If you are building from a corporate network, build.sh will detect your local `$http\_proxy` to use it in docker build.

By default, the image is builded with docker 1.9.1. If you want to set another image containing another docker binary, use build.sh with an extra parameter:

    $ bin/build.sh MyRepo 1.10.3

