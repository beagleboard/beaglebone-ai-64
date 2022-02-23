#!/bin/sh
docker run \
	-it \
	--privileged \
	-v /dev:/dev \
	--network host \
	tisdk-minimal \
	/bin/bash

