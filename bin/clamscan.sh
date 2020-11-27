#!/bin/bash

HERE=$(dirname $(realpath "$0"))
. "${HERE}/common"

/usr/bin/freshclam 1>"${LOG_FILE}" 2>&1
/usr/bin/clamscan -ir --exclude=/proc --exclude=/dev --exclude=/media 1>>"${LOG_FILE}" 2>&1
