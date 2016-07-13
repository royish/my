#!/bin/sh
for arg in "$@" ; do
  if [ ${arg:0:1} == "R" ]; then
    REV=$arg
  fi
done

do_patch.sh $*
./$REV\_patch.sh > $REV.tmp.diff

diff_strip.sh $REV.tmp.diff $REV.diff

