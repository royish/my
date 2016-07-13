#! /bin/bash

REV_ID=`rev2rev.sh $1`
REVIEW_FILE="$HOME/tmp/review/`mysql -h mysql -D jdoc -e \"select \
__file from reviews where id=$REV_ID\" -s | sed 's/review\///'`";

bug=`cat $REVIEW_FILE | grep TITLE | sed s'/TITLE: //g'`

echo $bug
