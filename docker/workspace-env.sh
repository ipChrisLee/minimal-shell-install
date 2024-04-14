# Intro:
#   Env var settings used in container runtime.
# Usage:
#   In Dockerfile, this file is catted to /etc/environment, so env vars are avaible.

export PATH="/install:$PATH"

#############
# net proxy #
#############
# to enable proxy settings, add `-e needRuntimeProxy="y"` when executing `docker run`.
if [[ "$needRuntimeProxy" ]]; then
	export http_proxy="WRAPPER_HTTP_PROXY"
	export https_proxy="WRAPPER_HTTPS_PROXY"
	export all_proxy="WRAPPER_ALL_PROXY"
	export no_proxy="WRAPPER_NO_PROXY"
fi
