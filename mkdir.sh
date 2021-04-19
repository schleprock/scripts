#! /usr/bin/env bash

if ! /usr/bin/mkdir.cygwin.exe -p $1; then
    echo "ERROR: failed to create directory: $1"
    echo
    exit 1
fi
echo "created $1"
if ! chmod 775 $1; then
    echo "ERROR: failed to chmod 775 $1"
    echo
    exit 2
fi
exit 0
