#!/bin/bash

# set -x
secs=0

while ((1)); do
    ps_make=`ps -C make -C cvs | grep -v PID`
    if [ -z "$ps_make" ]; then 
        break;
    fi
#    DEBUG="$ps_make; "
    echo $DEBUG make $((secs/60)) minutes and $((secs%60)) seconds from when started to wait
    secs=$((secs+1))
    sleep 1
done



