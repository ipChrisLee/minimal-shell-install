#!/usr/bin/env bash

source /etc/environment

########################
# start cron if exists #
########################
if (which cron > /dev/null 2>&1); then
    cron
fi

#######
# run #
#######
echo "Start running \"$@\""

exec "$@"

