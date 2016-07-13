#!/bin/bash

PARAMS=
while [ $# -gt 2 ]
do
    PARAMS=$PARAMS" "$1" "$2
    shift
    shift
done

REV=$1
REVHASH=${REV:$((-2)):2}
REVFILE=$REVHASH/$REV
TMPFILE=/tmp/$REV.rs.tmp

pushd ~/review > /dev/null
if [[ -f $REVFILE ]] ; then
  cvs -qf up $REVFILE
else
  cvs -qf co -d $REVHASH review/$REVFILE
fi
popd > /dev/null

cat ~/review/$REVFILE > $TMPFILE
echo >> $TMPFILE
echo -------------------------------------------------------------- >> $TMPFILE
echo >> $TMPFILE
cd ~/rg.dev
review diff $PARAMS -ux $REV >> $TMPFILE

#gvim -f -c "setf diff" $TMPFILE

if [[ ! -f /dev/stdout && ! -p /dev/stdout ]] ; then
  #cat $TMPFILE | colordiff | less -R
  cat $TMPFILE | less -R
else
  cat $TMPFILE
fi

#rm -f $TMPFILE
