#!/bin/bash

#setup
host=192.168.1.2
port=8080
username=
password=
pingidx=36
downloadidx=37
uploadidx=38

# no need to edit
touch ~/output.txt
speedtest-cli --simple > ~/output.txt
ping=$(cat ~/output.txt | sed -ne 's/^Ping: \([0-9]*\.[0-9]*\).*/\1/p')
download=$(cat ~/output.txt | sed -ne 's/^Download: \([0-9]*\.[0-9]*\).*/\1/p')
upload=$(cat ~/output.txt | sed -ne 's/^Upload: \([0-9]*\.[0-9]*\).*/\1/p')

#output if you run it manually
echo "ping = $ping ms"
echo "download = $download Mbps"
echo "upload =  $upload Mbps"

curl -s -i -H "Accept: application/json" "http://$username:$password@$host:$port/json.htm?type=command&param=udevice&idx=$pingidx&svalue=$ping"
curl -s -i -H "Accept: application/json" "http://$username:$password@$host:$port/json.htm?type=command&param=udevice&idx=$downloadidx&svalue=$download"
curl -s -i -H "Accept: application/json" "http://$username:$password@$host:$port/json.htm?type=command&param=udevice&idx=$uploadidx&svalue=$upload"

