#!/bin/bash
service=transmission-daemon

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
sudo /etc/init.d/$service restart
else
sudo /etc/init.d/$service start
fi
