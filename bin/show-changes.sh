#!/bin/bash

HERE=$(dirname $(realpath "$0"))
NOLOG=1
. "${HERE}/common"

function colorise
{
    local line=
    while read line; do
        echo -e "\033[$1m${line}\033[0m"
    done
}

function latest
{
    find "${LOG_BASE}" -mindepth 2 -type f -iname "*$1*" | sort | tail -n 1
}

function penulti
{
    find "${LOG_BASE}" -mindepth 2 -type f -iname "*$1*" | sort | tail -n 2 | head -n 1
}

function show_changes
{
    local what=$1
    local noun=$2
    local curr=$(latest "${what}.log")
    local prev=$(penulti "${what}.log")
    echo "========================================[ ${what} ]========================================" >&2
    if [[ -f "${prev}" ]] && [[ -f "${curr}" ]] && [[ "${prev}" != "${curr}" ]]; then
        # Show lines in curr not in prev
        echo "*** New ${noun} in ${what}.log"
        if [[ $(diff "${curr}" "${prev}" | grep '>') = "" ]]; then
            echo "None" >&2
        else
            diff "${curr}" "${prev}" | grep '>' | colorise "1;31"
        fi
    elif [[ -f "${curr}" ]]; then
        echo "*** New ${noun} in ${what}.log:"
        local count=0
        while read line; do echo "> $line"; count=$[count + 1]; done <"${curr}" | colorise "1;31"
        [[ $count -eq 0 ]] && echo "None" >&2
    else
        echo "*** ${what} hasn't run yet" | colorise "1;33" >&2
    fi
    echo "" >&2
}

show_changes archaudit "Vulnerabilities"
show_changes rkhunter "Warnings" | grep -iE 'warning|suspect|possible' | grep -viE 'none|one or more'
show_changes clamscan "Suspicious files" | grep -iE 'found|infected'
show_changes lynis "Suggestions"  | grep -iE 'warning|solution|https|!|\*'
