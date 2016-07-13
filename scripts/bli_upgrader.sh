IP=`ifconfig eth4 | grep "inet addr" | sed 's/.*inet addr:\(.*\) Bcast.*/\1/g'`;

/etc/init.d/xinetd stop
java -jar /home/shaulir/bin/BliUpgraderFull.jar $1 -i $IP
/etc/init.d/xinetd start
