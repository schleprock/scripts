#!/usr/bin/env bash

export DISPLAY=10.52.2.121:0.0
lHostName=`hostname`
rgb=""
if [ "$lHostName" = "burbld7a" ]; then
    rgb="-bg rgb:f0/ff/ff"
elif [ "$lHostName" = "burvmbldw764" ]; then
    rgb="-bg rgb:ff/fa/d8"
fi
xterm $rgb &
exit
