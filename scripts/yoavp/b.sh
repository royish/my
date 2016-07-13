#!/bin/bash

if [[ -z `pwd | grep ".*rg\.[^\/]*\/build"` ]] ; then
	LOC=`pwd | sed -e "s/\(.*rg\.[^\/]*\)\/\(.*\)/\1\/build\/\2/"`
else
	LOC=`pwd | sed -e "s/\(.*rg\.[^\/]*\)\/build\(.*\)/\1\2/"`
fi
cd $LOC

