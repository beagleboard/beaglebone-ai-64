#!/bin/sh
docker run \
	-it \
	-v /dev:/dev \
	--dns 192.168.0.1 \
	tisdk \
	/bin/bash
