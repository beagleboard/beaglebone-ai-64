#!/bin/sh
docker run --name temp-tisdk tisdk /bin/true
docker cp temp-tisdk:/opt/tivision_apps.tar.xz .
docker rm temp-tisdk
