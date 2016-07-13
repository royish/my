#!/bin/sh

lang=14 # hebrew
if [ "$2" == "e" ] ;then
    lang=0 # english
fi

mozilla "http://info.babylon.com/cgi-bin/info.cgi?word=$1&lang=$lang&ot=1&layout=combo.html&n=10" &
