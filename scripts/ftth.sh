#! /bin/bash

WAN=eth0
BOX_WAN=eth2
SELF=$(basename $0)

DATA_VLAN=10
IPTV_VLAN=20
VOICE_VLAN=30
MGT_VLAN=40

IP=`ifconfig $WAN | grep "inet addr" | sed 's/.*inet addr:\(.*\) Bcast.*/\1/g'`
if [ "$IP" == "" ]; then
  IP=`ifconfig br0 | grep "inet addr" | sed 's/.*inet addr:\(.*\) Bcast.*/\1/g'`;
fi
MASK=`ifconfig $WAN | grep "Mask" | sed 's/.*Mask:\(.*\)/\1/g'`
if [ "$MASK" == "" ]; then
  MASK=`ifconfig br0 | grep "Mask" | sed 's/.*Mask:\(.*\)/\1/g'`
fi
GW=`route -n | grep "^0\.0\.0\.0" | sed 's/0\.0\.0\.0\s*\(\S*\).*/\1/'`

case "$1" in
  'up')
    rt ifconfig $WAN down
    rt ifconfig $WAN 0 up
    rt ifconfig $BOX_WAN 0 up
    rt vconfig add $BOX_WAN $DATA_VLAN
    rt vconfig add $BOX_WAN $VOICE_VLAN
    rt vconfig add $BOX_WAN $IPTV_VLAN
    rt vconfig add $BOX_WAN $MGT_VLAN
    rt ifconfig $BOX_WAN.$DATA_VLAN 0 up
    rt ifconfig $BOX_WAN.$VOICE_VLAN 0 up
    rt ifconfig $BOX_WAN.$IPTV_VLAN 0 up
    rt ifconfig $BOX_WAN.$MGT_VLAN 0 up
  
    rt brctl addbr br0
    rt brctl addif br0 $WAN
    rt brctl addif br0 $BOX_WAN.$DATA_VLAN
    rt brctl addif br0 $BOX_WAN.$VOICE_VLAN
    rt brctl addif br0 $BOX_WAN.$IPTV_VLAN
    rt brctl addif br0 $BOX_WAN.$MGT_VLAN
  
    rt ifconfig br0 $IP up netmask $MASK
#    rt ifconfig $BOX_WAN 192.168.61.10 #for u-boot's netboot
    rt route add default gw $GW

    rt ifconfig
    rt brctl show
    route -n
    ;;

  'down')
    rt ifconfig $WAN down
    rt ifconfig br0 down
  
    rt brctl delif br0 $BOX_WAN.$DATA_VLAN
    rt brctl delif br0 $BOX_WAN.$VOICE_VLAN
    rt brctl delif br0 $BOX_WAN.$IPTV_VLAN
    rt brctl delif br0 $BOX_WAN.$MGT_VLAN
    rt brctl delif br0 $WAN
    rt brctl delbr br0
  
    rt vconfig rem $BOX_WAN.$DATA_VLAN
    rt vconfig rem $BOX_WAN.$VOICE_VLAN
    rt vconfig rem $BOX_WAN.$IPTV_VLAN
    rt vconfig rem $BOX_WAN.$MGT_VLAN
  
    rt ifconfig $WAN $IP up netmask $MASK
    rt route add default gw $GW

    rt ifconfig
    rt brctl show
    route -n
    ;;
  
  *)
  echo "Usage: $SELF up <voice wan dev>|down"
    exit 1
    ;;
esac
