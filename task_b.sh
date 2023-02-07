#!/usr/bin/env bash

function args {
	echo "Warning! Need one argument!"
	echo "Enter path to logfile"
	exit 1
}

if [[ $# -ne 1 ]]; then
	args
fi

echo "Most requests counts and IP:"
awk '{gsub(/ /, "", $1); print $1}' $1 | sort -k1 | uniq -c | sort -k1 | tail -5 | sort -rn | tail -1

echo "Enter counts rows of most requested pages wich you want to see:"
read -r count_rows
awk '{print $7}' $1 | sort -k2 | uniq -c | sort -k1 | tail -$count_rows | sort -rn

echo "Requests were there from each ip:"
awk '{gsub(/ /, "", $1); print $1}' $1 | sort -k1 | uniq -c | sort -k1 -rn

echo "Non-existent pages were clients referred to:"
awk '$9 ~ /404/ {print $7}' $1 | sort -k2 | uniq

echo "What time did site get the most requests (enter count rows wich you want to see):"
read -r count_rows1
awk '{print $4}' $1 | awk -F ":" '{print $2,":", $3}' | uniq -c | sort -k1 -n | tail -$count_rows1

echo "What search bots have accessed the site:"
grep -i bot $1  | cut -d " " -f 1,12- | sort -k1 | uniq | awk '{print $1, $NF'} | awk '{print substr($0, 1, length($0)-3)}' |  uniq