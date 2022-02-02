#!/bin/sh
docker run \
	-it \
	--privileged \
	-v /dev:/dev \
	--network host \
	tisdk \
	/bin/bash

