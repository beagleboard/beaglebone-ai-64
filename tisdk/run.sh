#!/bin/sh
docker run \
	-it \
	--privileged \
	-v /dev:/dev \
	--dns 192.168.0.1 \
	tisdk \
	/bin/bash
