#!/bin/bash

if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run as root" >&2
    exit 1
fi

PREFIX="${HOME}/.cronjobs"
git clone -o "${PREFIX}" "https://github.com/ChrisSwinchatt/CronJobs"
find "${PREFIX}" -name '*.sh' -exec chmod +x {} \;
"${PREFIX}/deploy.sh"
