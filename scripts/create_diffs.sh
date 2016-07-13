#!/bin/sh
for arg in "$@" ; do
  if [ ${arg:0:1} == "R" ]; then
    REV=$arg
  fi
done

# review diff
create_diff.sh $*

# inserted diff
cvs diff -uN -kk `cat $REV""_inserted.list` > $REV\_inserted.tmp.diff
diff_strip.sh $REV\_inserted.tmp.diff $REV\_inserted.diff

gvimdiff $REV.diff $REV\_inserted.diff
