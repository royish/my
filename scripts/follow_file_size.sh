#!/bin/sh

file_to_follow=$1
expected_size=$2

sz()
{
    ls -l $file_to_follow | cut -f 5 -d " "
}

interval=30

while ((1)); do
    b=`sz`
    sleep $interval
    a=`sz`

    d=$((a-b))

#   echo rate in bytes per second =  $((d/interval)) 
   left_bytes=$((expected_size-a))
   time_left_in_tens_of_seconds=$((left_bytes/d))
   time_left_in_seconds=$((time_left_in_tens_of_seconds*interval))
   echo time left:$((time_left_in_seconds/60)) minutes size left to download: $((left_bytes/1000000)) MB



done

