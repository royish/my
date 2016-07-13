#!/bin/sh

sed -e 's/@@\(.*\)@@/@@ HUNK @@/g' $1 | grep -v "+++" | grep -v "\-\-\-" | \
  grep -v "retrieving revision" | grep -v "diff \-u " | grep -v "diff \-N " | \
  grep -v "RCS file:" | grep -v "======" | grep -v "\$Header.*\$" | \
  grep -v "^U " | sed -e 's%Index: rg/\(.*\)%Index: \1%g' > $2

