#!/bin/bash
ROUTER=0
INTERNET=0
LAN=0
SECONDARY=0

ping -c 1 -I wlan0 192.168.1.1 >/dev/null && ROUTER=1
ping -c 1 -I eth0 8.8.8.8 >/dev/null && INTERNET=1
ping -c 1 -I wlan0 192.168.1.2 >/dev/null && LAN=1
ping -c 1 -I wlan0 192.168.2.1 >/dev/null && SECONDARY=1


