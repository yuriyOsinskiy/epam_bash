#!/usr/bin/env bash

logfile="/tmp/myrsync.log"

function args {
	echo "Need two arguments: source folder path and destination folder path!"
	echo "LogFile will be on path $logfile"
	echo "Enter two path"
	exit 1
}

if [[ $# -ne 2 ]]; then
	args
fi
if [[ -d $1 ]] && [[ -d $2 ]]; then
    rsync -au --delete --log-file $logfile $1 $2
else
	args
fi
