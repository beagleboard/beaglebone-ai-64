#!/bin/sh
export DOCKER_BUILDKIT=1
docker build \
	-t tisdk \
	-f Dockerfile.`arch` \
	.

