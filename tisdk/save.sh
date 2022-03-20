#!/bin/sh

# I need to go through here and be more selective in what is copied
docker build \
	-t tisdk-minimal \
	--squash \
	--compress \
	- <<EOF
FROM scratch
COPY --from=tisdk / /
EOF

docker save tisdk-minimal -o tisdk.tar

xz tisdk.tar
