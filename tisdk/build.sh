#!/bin/sh
export DOCKER_BUILDKIT=1
docker build \
	--network host \
	-t tisdk \
	-f Dockerfile.`arch` \
	.
