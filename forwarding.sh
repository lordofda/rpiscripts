#!/bin/bash
#$1 - input port
#$2 - output port
#$3 - output ip


usage(){
	echo "Usage: forwarding.sh [input_port] [output_port] [output_ip]"
}

#if [ $# -ne 3] ; then
#	usage
#	exit 1
#fi
#
#if [[ $1 == "--help" || $1 == "-h" ]] ; then
#	usage
#	exit 1
#fi
#
#if [[ $USER != "root" ]] ; then
#	echo "script must be run as root"
#	usage
#	exit 1
#fi

INPORT=$1
OUTPORT=$2
OUTIP=$3

echo "Putting new rule From *:"$INPORT" to "$OUTIP":"$OUTPORT

iptables -t nat -A PREROUTING -p tcp --dport $INPORT -j DNAT --to-destination $OUTIP:$OUTPORT
iptables -A FORWARD -p tcp -d $OUTIP --dport $OUTPORT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE
