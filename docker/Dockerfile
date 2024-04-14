FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG ALL_PROXY
ARG NO_PROXY
ARG timeZone

# ------------ directories ------------
# ---- docker workdir
WORKDIR /tmp
# ---- /install : user program | /workspace : workspace of container
RUN mkdir -p /install /workspace

# ------------ proxy settings ------------
# ---- proxy for apt.
RUN echo > /etc/apt/apt.conf
RUN if [ -n "$HTTP_PROXY" ]; then echo "Acquire::http::Proxy \"$HTTP_PROXY\";" >> /etc/apt/apt.conf; fi
RUN if [ -n "$HTTPS_PROXY" ]; then echo "Acquire::https::Proxy \"$HTTPS_PROXY\";" >> /etc/apt/apt.conf; fi

# ------------ apt install ------------
RUN apt-get update
RUN apt-get install nano curl -y

# ------------ timezone  ------------
# ---- set time zone.
RUN apt-get install tzdata -y
RUN if [ -n "$timeZone" ]; then echo "$timeZone" > /etc/timezone; fi
RUN if [ -n "$timeZone" ]; then ln -sf "/usr/share/zoneinfo/${timeZone}" /etc/localtime; fi


# ------------ /etc/environment for env var ------------
# ---- from /docker/workspace-env.sh.
COPY /docker/workspace-env.sh /tmp/
RUN sed -i -e "s|WRAPPER_HTTP_PROXY|${HTTP_PROXY}|" /tmp/workspace-env.sh
RUN sed -i -e "s|WRAPPER_HTTPS_PROXY|${HTTPS_PROXY}|" /tmp/workspace-env.sh
RUN sed -i -e "s|WRAPPER_ALL_PROXY|${ALL_PROXY}|" /tmp/workspace-env.sh
RUN sed -i -e "s|WRAPPER_NO_PROXY|${NO_PROXY}|" /tmp/workspace-env.sh
RUN cat /tmp/workspace-env.sh >> /etc/environment
RUN echo 'source /etc/environment' >> /root/.bashrc

# ------------ minimal shell install ------------
RUN bash <(curl -s https://raw.githubusercontent.com/ipChrisLee/minimal-shell-install/master/run.sh)

# ------------ entrypoint ------------
COPY /docker/entrypoint.sh /install
ENTRYPOINT ["/install/entrypoint.sh"]

# ------------ run ------------
WORKDIR /workspace
CMD /bin/bash
