#!/bin/execlineb -P
s6-setuidgid root
s6-looper -i 60 /usr/local/bin/monitor.sh
