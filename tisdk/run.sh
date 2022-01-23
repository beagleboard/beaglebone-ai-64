#!/bin/sh
docker run \
	-it \
	--dns 192.168.0.1 \
	tisdk \
	/bin/bash
