#!/bin/bash -ex
DOCKER_BUILDKIT=1 docker build \
	-t tisdk \
	-f Dockerfile.`arch` \
	.

docker build \
	-t tisdk-minimal \
	--squash \
	--compress \
	- <<EOF
FROM scratch
COPY --from=tisdk / /
EOF
