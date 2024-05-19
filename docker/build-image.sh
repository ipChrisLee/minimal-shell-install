#!/usr/bin/env bash

if [ ! -f "docker/anchor" ] || [ "$(head -1 docker/anchor)" != "docker | msi-test-docker" ]; then echo "Anchor [docker] not found!"; exit 1; fi

source docker/build-stage-env.sh

echo "Building with settings:"

echo "http_proxy=$http_proxy"
echo "https_proxy=$https_proxy"
echo "all_proxy=$all_proxy"
echo "no_proxy=$no_proxy"

echo "timeZone=$timeZone"
echo "ghMsiToken=$ghMsiToken"

echo "BEGIN DOCKER BUILD: "
echo "===================="

docker buildx build \
	--tag msi-test_image \
    --build-arg HTTP_PROXY="$http_proxy" \
    --build-arg HTTPS_PROXY="$https_proxy" \
    --build-arg ALL_PROXY="$all_proxy" \
    --build-arg NO_PROXY="$no_proxy" \
    --build-arg timeZone="$timeZone" \
	--build-arg ghMsiToken="$ghMsiToken" \
    --network host \
    -f docker/Dockerfile \
	"$@" \
    ${projRoot}
# --progress=plain --no-cache \
