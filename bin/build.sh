#!/bin/bash -ex
#
#

if [ "$http_proxy" != "" ]
then
   PROXY="--build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy --build-arg no_proxy=$no_proxy"
fi

if [ "$1" = "" ]
then
   echo "Syntax is $0 [registry[:port]/]repo [DOCKER_VERSION]
where :
  [registry[:port]/]repo : is the Repository used to publish to."
   exit 1
fi

if [ "$2" = "" ]
then
   DOCKER_VERSION=1.9.1
else
   DOCKER_VERSION="$2"
fi

docker build -t $1/jenkins-slave-dood:$DOCKER_VERSION --build-arg DOCKER_VERSION=$DOCKER_VERSION $PROXY .
docker push $1/jenkins-slave-dood:$DOCKER_VERSION

