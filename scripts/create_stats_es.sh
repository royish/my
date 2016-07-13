#!/bin/bash

create_stats_inc=`dirname $0`/create_stats.sh
. $create_stats_inc

bugs="105985 110009 109986 110024 124605 124713 105981 124129 126079 110092 110198"

#bugs=105980
debug=""

echo "date:,`date`"
echo
echo Bid,desc,remaining_P1P2,percent_done,invested,comment

print_for_bug "105980"

ui_bug=122267

echo

(
for i in $bugs ; do 
    print_for_bug $i;
done 

print_for_bug $ui_bug priority p1 desc "UI user";
print_for_bug $ui_bug priority p2 desc "UI admin" invested 0 comment "see 'invested' in UI user";

) | sort -t, -k 5 -n -r

