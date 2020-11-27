#!/bin/bash

HERE=$(dirname $(realpath "$0"))
. "${HERE}/common"

/usr/bin/lynis audit system -Q >${LOG_FILE}
