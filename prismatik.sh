#!/bin/bash
echo "$1"
{ echo "lock"; echo "$1"; echo "unlock"; echo "exit"; } | telnet 192.168.0.101 3636
