#!/usr/bin/env bash

if [ ! -f "docker/anchor" ] || [ "$(head -1 docker/anchor)" != "docker | msi-test-docker" ]; then echo "Anchor [docker] not found!"; exit 1; fi

docker run \
    --name=msi-test \
    --network=host \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    --restart=always \
    -itd msi-test_image

