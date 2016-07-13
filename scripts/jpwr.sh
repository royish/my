#!/bin/bash

case "$1" in
on)
	stty -F /dev/ttyS0 115200
	;;
off)
	stty -F /dev/ttyS0 0
	;;
reset)
	stty -F /dev/ttyS0 0
	sleep 1
	stty -F /dev/ttyS0 115200
	;;
esac

exit 0
