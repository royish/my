#!/bin/bash

create_stats_inc=`dirname $0`/create_stats.sh
. $create_stats_inc

bugs="126536 126640 126644 126652 126654 126658 126663 126667 126671 126675 126679 126681"

#bugs=105980
debug=""

echo "date:,`date`"
echo
echo Bid,desc,remaining_P1P2,percent_done,invested,comment

print_for_bug "125486"

echo

(
for i in $bugs ; do 
    print_for_bug $i;
done 
) | sort -t, -k 5 -n -r

