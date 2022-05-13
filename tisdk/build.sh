#!/bin/bash -ex

DOCKERTAG=tisdk:8.1
DOCKERFILE=Dockerfile.aarch64

# modify the server and proxy URLs as requied
ping bitbucket.itg.ti.com -c 1 > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
    USE_PROXY=1
    HTTP_PROXY=http://webproxy.ext.ti.com:80
else
    USE_PROXY=0
fi

REPO_LOCATION=`docker inspect --format='{{.Os}}/{{.Architecture}}' tisdk_base`

# Build docker image
DOCKER_BUILDKIT=1 docker build \
    -t $DOCKERTAG \
    --build-arg USE_PROXY=$USE_PROXY \
    --build-arg REPO_LOCATION=$REPO_LOCATION \
    --build-arg HTTP_PROXY=$HTTP_PROXY \
    --build-arg PSDK_RTOS_VER=08_01_00_13 \
    --build-arg TIDL_LIB_PKG=tidl_j7_08_01_00_05 \
    --build-arg TENSORFLOW_TAG=TIDL_PSDK_8.1 \
    --build-arg OSRT_TAG=TIDL_PSDK_8.1 \
    --build-arg ROBOTICS_SDK_TAG=REL.08.01.00.05 \
    --build-arg EDGEAI_APPS_TAG=REL.PSDK.LINUX.SK.TDA4VM.08.01 \
    --build-arg EDGEAI_GST_PLUGINS_TAG=release-0.5.3 \
    --build-arg EDGEAI_TIOVX_MODULES_TAG=release-0.2 \
    --build-arg FLATBUFFERS_VERSION=v1.12.0 \
    --build-arg PROTOBUF_VER=3.11.3 \
    -f $DOCKERFILE .

