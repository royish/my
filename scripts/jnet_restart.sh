#!/bin/bash
. /usr/local/bin/jtools_functions.sh

D=`jpwdroot`

cd $D/build/pkg/jnet/server/jnet/jnet/install;
rt /etc/init.d/jnet stop && rt ./jnet_install.sh -f /usr/local/jnet_installations/jnet/jrms/jnet.conf -c jacs,db,jrms && rt /etc/init.d/jnet start
