#!/bin/bash

# $1 - review id (Rxxx)
# $2 - 1st branch
# $3 - 2nd branch

strip_diffs()
{
    sed -e 's/@@\(.*\)@@/@@ HUNK @@/g' $1 | grep -v "+++" | grep -v "\-\-\-" | grep -v "retrieving revision" | grep -v "diff \-u " | grep -v "diff \-N " | grep -v "RCS file:" | grep -v "======" | grep -v "\$Header.*\$" > $2
}

mkdir -p /tmp/cmerge
diff1=/tmp/cmerge/$1.$2.diff
diff2=/tmp/cmerge/$1.$3.diff
diffdiff=/tmp/cmerge/$1.$2_$3.diff
review diff -x -c -s -u -b $2 $1 > $diff1.tmp
review diff -x -c -s -u -b $3 $1 > $diff2.tmp

strip_diffs $diff1.tmp $diff1
strip_diffs $diff2.tmp $diff2

diff -I \$Id: cmerge.sh,v 1.2 2012/04/24 07:15:08 royi Exp $Revision: 1.2 $Date: 2012/04/24 07:15:08 $Header: /arch/cvs/home/royi/my/scripts/yoavp/scripts/old/cmerge.sh,v 1.2 2012/04/24 07:15:08 royi Exp $diff1 $diff2 > /dev/null
if [ 1 -eq $? ] ; then
    diff -u $diff1 $diff2 > $diffdiff.tmp
    strip_diffs $diffdiff.tmp $diffdiff
    grep -E "\+\+|\-\-|\+\-|\-\+" $diffdiff > /dev/null
    if [ 1 -eq $? ] ; then
        echo "$1: Code NOT identical (context)"
    else
        echo "$1: Code NOT identical"
	xxdiff $diff1 $diff2
    fi
else
    echo $1: Code identical
fi

