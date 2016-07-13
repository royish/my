#!/bin/bash

ARG=$1

FILE_PATH=${ARG%/*}
FILE_NAME=${ARG##*/}

cd $FILE_PATH
cvs up $FILE_NAME

gvim -f $FILE_NAME $2

diff=`cvs diff $FILE_NAME | wc -l`
if [ $diff == 0 ]; then
	exit	
fi

#echo Do you wish to commit changes to project.txt ?
cvsdiff $FILE_NAME
cvs ci $FILE_NAME

