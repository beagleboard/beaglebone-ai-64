#!/bin/bash -ex
DOCKER_BUILDKIT=1 docker build \
	-t tisdk2 \
	-f Dockerfile2.`arch` \
	.

