for i in 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15 16;
do ~/jt_runner.sh 2>&1 | grep "Bytes on wire\|Transfer\|Started" > ~/weekend_res/res$i;
done
