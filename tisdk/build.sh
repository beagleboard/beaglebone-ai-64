#!/bin/bash -ex
docker build \
	-t tisdk-debian \
	-f Dockerfile.`arch` \
	--target=tisdk-debian \
	.

