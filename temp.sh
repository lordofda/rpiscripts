#!/bin/bash
var=$(/opt/vc/bin/vcgencmd measure_temp | sed  -r "s/temp\=([0-9][0-9].[0-9])*/\1/")
var=${var%??}
curl -m 120 -s -o /dev/null  "192.168.0.107:8080/json.htm?type=command&param=udevice&idx=37&nvalue=0&svalue="$var
