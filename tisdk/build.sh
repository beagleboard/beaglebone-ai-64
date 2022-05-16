#!/bin/bash -ex
DOCKER_BUILDKIT=1 docker build \
	-t ti-tflite \
	-f Dockerfile.`arch` \
	--target=ti-tflite \
	.

