#!/bin/bash -ex

DOCKERTAG=tisdk_x86
DOCKERFILE=Dockerfile.x86_64

# modify the server and proxy URLs as requied
ping bitbucket.itg.ti.com -c 1 > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
    USE_PROXY=1
    REPO_LOCATION=artifactory.itg.ti.com/docker-public/library/
    HTTP_PROXY=http://webproxy.ext.ti.com:80
else
    REPO_LOCATION=
    USE_PROXY=0
fi

# Build docker image
DOCKER_BUILDKIT=1 docker build \
    -t $DOCKERTAG \
    --build-arg USE_PROXY=$USE_PROXY \
    --build-arg REPO_LOCATION=$REPO_LOCATION \
    --build-arg HTTP_PROXY=$HTTP_PROXY \
    --build-arg PSDK_LINUX_VER=08_02_00_03 \
    --build-arg PSDK_RTOS_VER=08_02_00_05 \
    -f $DOCKERFILE .

