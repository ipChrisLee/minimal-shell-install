# Usage:
#   `source docker/build-stage-env.sh` in `build-image.sh` to get env vars used in build stage.

if [ ! -f "docker/anchor" ] || [ "`head -1 docker/anchor`" != "docker | msi-test-docker" ]; then echo "Anchor [docker] not found!"; exit 1; fi

source secret/config.sh

export projRoot="`pwd`"

if [ -z "$timezone" ]; then
	export timeZone="`cat /etc/timezone`"
fi
