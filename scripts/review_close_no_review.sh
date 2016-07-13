#!/bin/sh

cd

re_single()
{
    R=R$1
    R=${R/RR/R}
    rem=${R%[0123456789][0123456789]};
    SUF=${R/$rem/}

    rm -rf $HOME/review
    f=review/$SUF/$R

    cvs co $f
    cvs co -p $f | sed -e 's/STATUS: ASSIGNED/STATUS: CLOSED/g' | sed -e 's/REMARKS:/REMARKS: closing without review/g' > $f

    
    cvs ci -m "Updated by review  edit" $f
}

if [ "$1" == "--not_interactive" ]; then 
    shift
    DIFFPROG=true
fi

input=`echo $@ | sed -e 's/R/ R/g'`
for i in $input; do re_single $i; done

