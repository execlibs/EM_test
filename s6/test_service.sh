#!/bin/execlineb -P

s6-setuidgid root
foreground { /usr/local/bin/monitor.sh }
s6-svscanctl -t /etc/s6/services
