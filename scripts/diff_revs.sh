#!/bin/sh -x

create_diff.sh $1
create_diff.sh $2
gvimdiff $1.diff $2.diff
