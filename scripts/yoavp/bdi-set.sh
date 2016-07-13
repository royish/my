#!/bin/sh
./bdisetup -c -p/dev/ttyS1 -i192.168.71.40 -m255.255.255.0 -g192.168.71.1 -h192.168.71.$1 -fbdi2000_ti.cfg
./bdisetup -v -p/dev/ttyS1 -s
