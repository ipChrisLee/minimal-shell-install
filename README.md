# minimal-shell-install

## Intro

**I public this repo in GitHub is just to make myself convenient. This is not a repo for open-source community.**

Minimal shell develop environment installation for iplee.

This project provide a simple, one-step way to install shell dev env. This is useful for docker container. By running this once, you can have greet shell dev env for development.

This project depends on `.iplee-conf` and `.iplee-exe`. This a trade-off. Ideally, this project should not depend on another project, but since `.iplee-conf` and `.iplee-exe` have saved a lot of configs I am using, this project should depend on them.

This installation only supports linux for now (i.e. only sync with linux-port from .iplee-conf).

To run this, just:
```
RUN bash <(curl -s https://raw.githubusercontent.com/ipChrisLee/minimal-shell-install/master/run.sh)
```

To enable config, you can:
```
RUN echo > msi-config.sh
RUN echo 'nvimTreesitterLangs=bash,diff,lua,markdown,python,yaml' >> msi-config.sh
RUN bash <(curl -s https://raw.githubusercontent.com/ipChrisLee/minimal-shell-install/master/run.sh)
```
For all configs see `run.sh`.

## Proj structure

README.md : this file.

run.sh : one-file script for installation.

docker : folder for **test** in docker.
