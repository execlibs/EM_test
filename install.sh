#!/bin/sh

cp ./monitor.sh /usr/bin
cp ./Systemd/test.service /usr/lib/systemd/system
cp ./Systemd/test.timer /usr/lib/systemd/system

cd /usr/bin

systemctl daemon-reload
systemctl enable test.service
systemctl enable test.timer
systemctl start test.timer
