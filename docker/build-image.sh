#!/usr/bin/env bash

if [ ! -f "docker/anchor" ] || [ "`head -1 docker/anchor`" != "docker | msi-test-docker" ]; then echo "Anchor [docker] not found!"; exit 1; fi

source docker-def/build-stage-env.sh

echo "Building with settings:"

echo "http_proxy=$http_proxy"
echo "https_proxy=$https_proxy"
echo "all_proxy=$all_proxy"
echo "no_proxy=$no_proxy"

echo "timeZone=$timeZone"

echo "BEGIN DOCKER BUILD: "
echo "===================="

docker build \
	--tag msi-test-image \
    --build-arg HTTP_PROXY="$http_proxy" \
    --build-arg HTTPS_PROXY="$https_proxy" \
    --build-arg ALL_PROXY="$all_proxy" \
    --build-arg NO_PROXY="$no_proxy" \
    --build-arg timeZone="$timeZone" \
    --network host \
    -f Dockerfile \
    ${projRoot}
# --progress=plain --no-cache \


