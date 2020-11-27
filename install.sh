#!/bin/bash

PREFIX="${HOME}/.cronjobs"
git clone -o "${PREFIX}" "https://github.com/ChrisSwinchatt/CronJobs"
find "${PREFIX}" -name '*.sh' -exec chmod +x {} \;
"${PREFIX}/deploy.sh"
