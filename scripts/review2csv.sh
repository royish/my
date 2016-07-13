#! /bin/bash

REVIEWID="`echo $1 | sed 's/^R//'`"

REVIEW_FILE="$HOME/tmp/review/`mysql -h mysql -D jdoc -e \"select \
__file from reviews where id=$1\" -s | sed 's/review\///'`";

bugs=`cat $REVIEW_FILE | grep BUGS | sed s'/BUGS: //g'`
title=`cat $REVIEW_FILE | grep TITLE | sed s'/TITLE: //g' |sed s'/B[0-9]*: //g'`

for i in $bugs; do
  bug=`echo $i | sed -e 's%B\(.*\).*%\1%'`
  descs+="$i: `bug2desc.sh $bug` "
done

echo "R$1;$title;$bugs;$descs"
