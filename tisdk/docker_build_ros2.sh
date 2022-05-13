#!/bin/bash
DOCKER_TAG=tisdk-ros-foxy:8.1
DOCKER_DIR=/home/vijayp/beaglebone-ai-64/tisdk
# modify the server and proxy URLs as requied
ping bitbucket.itg.ti.com -c 1 > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
    USE_PROXY=1
    REPO_LOCATION=artifactory.itg.ti.com/docker-public/library/
    HTTP_PROXY=http://webproxy.ext.ti.com:80
else
    USE_PROXY=0
    REPO_LOCATION=
fi
echo "USE_PROXY = $USE_PROXY"
echo "REPO_LOCATION = $REPO_LOCATION"
docker build \
    -t $DOCKER_TAG \
    --build-arg USE_PROXY=$USE_PROXY \
    --build-arg REPO_LOCATION=linux/arm64\
    --build-arg HTTP_PROXY=$HTTP_PROXY \
    -f $DOCKER_DIR/Dockerfile.arm64v8.foxy .
