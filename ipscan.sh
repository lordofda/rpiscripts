#!/bin/bash
nmap 192.168.1.0/24 | sed  's/Nmap\ scan\ report\ for//' | sed '/53/d'
nmap 192.168.2.0/24 | sed  's/Nmap\ scan\ report\ for//' | sed '/53/d'
