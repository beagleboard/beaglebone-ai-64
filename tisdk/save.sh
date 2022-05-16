#!/bin/sh

# I need to go through here and be more selective in what is copied
#docker build \
#	-t ti-tflite-minimal \
#	--squash \
#	--compress \
#	- <<EOF
#FROM scratch
#COPY --from=ti-tflite / /
#EOF

docker save ti-tflite -o ti-tflite.tar

xz ti-tflite.tar
