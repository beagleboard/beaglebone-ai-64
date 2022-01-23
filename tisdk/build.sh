docker build \
	--network host \
	-t tisdk \
	-f Dockerfile.`arch` \
	.
