#! /bin/bash

DESC="`mysql -h mysql -D bugs_rg -e \"select \
short_desc from bugs where bug_id=$1\" -s | grep -v short_desc`";

echo $DESC
