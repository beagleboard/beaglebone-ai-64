#!/bin/bash -ex
DOCKER_BUILDKIT=1 docker build \
	-t tisdk \
	-f Dockerfile.`arch` \
	--target=ti-tflite \
	.

