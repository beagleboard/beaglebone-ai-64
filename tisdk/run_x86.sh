#!/bin/sh
docker run \
	--rm \
	-it \
	--privileged \
	-v /dev:/dev \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=$DISPLAY \
	-v $HOME/.Xauthority:/root/.Xauthority \
	--network host \
	tisdk_x86 \
	/bin/bash

