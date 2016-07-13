#!/bin/sh
for arg in "$@" ; do
  if [ ${arg:0:1} == "R" ]; then
    REV=$arg
  else
    args+=" $arg"
  fi
done

#review diff $args $REV | sort -k 7,7 -k 6,6 > $REV\_patch.sh.tmp
review diff $args $REV > $REV\_patch.sh.tmp
cat $REV\_patch.sh.tmp | sed 's/rdiff/rdiff -u -kk/g' | \
  grep -v "^U " > $REV\_patch.sh
rm $REV\_patch.sh.tmp
chmod +x $REV\_patch.sh
