#!/bin/bash

HOSTS="kermit adams albert animal beaker berl cartman ford fozzy golda gonzo grant hoover janet nixon rambam scooter sylar timmy wilson zalman"

# Start konsole and grab its name
konsole=$(dcopstart konsole-script)

SESSION=currentSession
for h in $HOSTS ; do
    # Use the first tab or create a new one
    tab=`dcop $konsole konsole $SESSION` ;
    dcop $konsole $tab renameSession "$h" ;
    dcop $konsole $tab sendSession "ssh bat@$h" ;
    dcop $konsole $tab sendSession "rt tail -f /home/bat/bat/std_log" ;
    SESSION=newSession
done

