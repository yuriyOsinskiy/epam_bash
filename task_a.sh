#!/usr/bin/env bash

arguments="You can use argument:
--all		-displays the IP addresses and symbolic names of all hosts in the current subnet
--target	-displays a list of open system TCP ports
"

function args {
	echo "Warning! Need one argument!"
	echo "$arguments"
	exit 1
}

if [[ $# -ne 1 ]]; then
	args	
else
	if [ $1 = "--all" ] || [ $1 = "--target" ]; then
		echo "OK, i can do this!"
	else
		args
	fi
fi
if [ $1 = "--all" ]; then
	echo "The IP addresses and symbolic names of all hosts in the this host's subnet:"
	arp -a | awk '{print $2, $1}'
elif [ $1 = "--target" ]; then
	echo "The list of open system TCP ports:"
	netstat -t4ln | awk '{print $4}' | awk -F":" '{print $NF}' | tail +3
fi
echo "Done!"