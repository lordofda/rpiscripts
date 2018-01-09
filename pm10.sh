#!/bin/bash
var1=$(curl -s -X GET 'http://powietrze.gios.gov.pl/pjp/current/getAQIDetails?id=798&param=AQI' | jq .values.PM10)
var2=$(curl -s -X GET 'http://powietrze.gios.gov.pl/pjp/current/getAQIDetails?id=798&param=AQI' | jq .values.CO)
var2=$(echo "${var2} * 1000" | bc)
curl -m 120 -s -o /dev/null  "192.168.0.107:8080/json.htm?type=command&param=udevice&idx=38&nvalue="$var1
curl -m 120 -s -o /dev/null  "192.168.0.107:8080/json.htm?type=command&param=udevice&idx=39&nvalue="$var2
echo $var1 $var2
