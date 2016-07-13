#! /bin/bash

REVIEWID="`echo $1 | sed 's/^R//'`"
REVIEW="R$REVIEWID"
REVIEW_PATH="`echo $REVIEWID | sed 's/.*\([0-9][0-9]\)/\1/'`"

cd /tmp/review/$REVIEW_PATH
cvs -q up $REVIEW

g $REVIEW
