#!/bin/bash
echo $2
{ echo "lock"; echo "$2"; echo "unlock"; echo "exit"; } | telnet $1 3636
