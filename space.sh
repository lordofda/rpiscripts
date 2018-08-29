#!/bin/bash
space1=$(df -h | grep $2 | sed -n -E 's/(^|.*[^0-9])([0-9]{1,3})%.*/\2/p')
space2=$(df -h | grep $4 | sed -n -E 's/(^|.*[^0-9])([0-9]{1,3})%.*/\2/p')
curl -m 120 -s -o /dev/null  $1":8080/json.htm?type=command&param=udevice&idx="$3"&nvalue=0&svalue="$space1
curl -m 120 -s -o /dev/null  $1":8080/json.htm?type=command&param=udevice&idx="$5"&nvalue=0&svalue="$space2

