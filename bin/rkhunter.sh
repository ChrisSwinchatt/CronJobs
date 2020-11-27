#!/bin/bash

HERE=$(dirname $(realpath "$0"))
. "${HERE}/common"

/usr/bin/rkhunter -c --sk 1>"${LOG_FILE}" 2>&1
