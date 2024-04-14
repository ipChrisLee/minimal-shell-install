# Usage:
#   `source docker/build-stage-env.sh` in `build-image.sh` to get env vars used in build stage.

if [ ! -f "docker/anchor" ] || [ "`head -1 docker/anchor`" != "docker | msi-test-docker" ]; then echo "Anchor [docker] not found!"; exit 1; fi

export projRoot="`pwd`"

if [ -z "$timezone" ]; then
	export timeZone="`cat /etc/timezone`"
fi

if [ -z "$msiGhKey" ]; then
	export msiGhKey="`cat ${HOME}/Downloads/gh_msi-token.txt`"
fi
