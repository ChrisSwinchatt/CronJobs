#!/bin/bash

NAME=$(basename "$0")
HERE=$(dirname $(realpath "$0"))

function add_cron_job
{
    set -e
    local target="${HERE}/bin/$2"
    local link="/etc/cron.$1/$2"
    [[ ! -f "${target}" ]] && echo "${NAME}: ${target}: No such file" >&2 && exit 1
    [[ ! -d "$(dirname "${link}")" ]] && echo "${NAME}: $(dirname "${link}"): No such directory" >&2 && exit 1
    [[ -f "${link}" ]] && rm "${link}"
    ln -s "${target}" "${link}"
    chmod +x "${target}" "${link}"
    echo "${NAME}: $2 will run $1"
    set +e
}

while read line; do
    add_cron_job $line
done <"${HERE}/deployment.cfg"
