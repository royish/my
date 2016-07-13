#!/bin/sh

cd ~/project/db
rm users.csv
cvs up users.csv

ja=c_vodafone_dev_es

names="kfir moshes itamarh royi avner ivand volodymyro alexf victor"

# remove all occurences
cat users.csv | sed -e "s/[ ]*\<c_vodafone_dev_es\>[ ]*//g" > /tmp/l
cp /tmp/l users.csv

# add
for i in $names; do 
  cat users.csv | sed -e "s/^\($i,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,\)\([^,]*\),\(.*\)/\1$ja \2,\3/g" > /tmp/l
  cp /tmp/l users.csv
done

cvsdiff  users.csv
