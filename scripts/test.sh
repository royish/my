#!/bin/bash
wget --output-file=/dev/null --save-cookies cookies --keep-session-cookies http://192.168.1.1/main.cgi
wget -O - --load-cookies /tmp/cookies --post-file=pfile http://192.168.1.1/data_model.cgi
