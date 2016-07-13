
number=`transformer-cli get sys.hosts.HostNumberOfEntries | sed -e 's/.*= //'`
i=1
while [ "$i" -le "$number" ]; do

  IP=`transformer-cli get sys.hosts.host.$i\.IPAddress | sed -e 's/.*= //'`
  MACAddress=`transformer-cli get sys.hosts.host.$i\.MACAddress | sed -e 's/.*= //'`
  
  OS=`p0f-client /var/run/p0f.sock $IP | grep "Detected OS" | sed -e 's/.*= //'`
  if [ "$OS" != "" ]; then
    ubus call hostmanager.device set '{"mac-address":""MACAddress"","p0f-os-detection":"$OS"}'
  fi
  
  UA=`p0f-client /var/run/p0f.sock $IP | grep "HTTP User Agent" | sed -e 's/.*= //'`
  if [ "$UA" != "" ]; then
    ubus call hostmanager.device set '{"mac-address":"MACAddress","p0f-os-detection":"$UA"}'
  fi
  
  i=$(($i + 1))
done
