#!/bin/bash

rt killall -9 quicksynergy
rt killall -9 synergys
ps ax | grep syner
quicksynergy > /dev/null 2>&1 &
