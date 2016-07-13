#!/bin/sh
review diff -u $1 $2 $3 $4 > $1.sh
chmod +x $1.sh
cat $1.sh | grep cvs | cut -f 8 -d ' ' > $1.list
cat $1.sh
./$1.sh > $1.patch
printf "Should I Patch? [y/n]\n"
read cont
if [ $cont == "y" ]; then
    printf "\n\n=============\n"
    patch -p1 < $1.patch
    printf "\n\n=============\n"
    cvs -q up `cat $1.list`
else
    printf "not patching...\n"
fi
