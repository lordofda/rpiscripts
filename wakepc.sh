#!/bin/bash
echo "setting connection"
/sbin/ifconfig eth0 inet 192.168.2.253 netmask 255.255.255.0 pointopoint 192.168.2.254
echo "bringing interface up"
/sbin/ifconfig eth0 up
sleep 15
echo "waking PC"
/usr/sbin/etherwake -i eth0 14:DA:E9:9B:F0:BB
sleep 5
echo "bringing interface down"
/sbin/ifconfig eth0 down
