#!/bin/sh

cd `/bin/pwd | \
  sed -e "s%os/linux-2.4%ZZZ%" -e "s%linux/%os/linux-2.4/%" \
    -e "s%os/linux-2.6%os/linux-2.4%" -e "s%ZZZ%os/linux-2.6%"`

if [ -z `/bin/pwd | grep linux` ]; then
    cdr os/linux-2.6
fi
