#! /bin/bash

REVIEWID="`echo $1 | sed 's/^R//'`"

REVIEW_FILE="$HOME/tmp/review/`mysql -h mysql -D jdoc -e \"select \
__file from reviews where id=$REVIEWID\" -s | sed 's/review\///'`";

bug=`cat $REVIEW_FILE | grep BUGS | sed s'/BUGS: //g'`


echo $bug
