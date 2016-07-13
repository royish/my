#!/bin/bash

if [ "$#" == "0" ]; then
    printf "Please enter a file to upgrade\n"
    exit 1
fi

sudo /home/shaulir/my/scripts/bli_upgrader.sh $1

