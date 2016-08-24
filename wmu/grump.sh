#!/bin/sh
#
# grump.sh - group manager
#

GROOT=/tmp/groups
GSTATROOT=/tmp/grpstat
GNUM=4

usage() {
	echo "$(basename $0) [-adsthp <gid>]"
}

ROOT=$(lsw -r)
CUR=$(pfw)

#
# define functions
#

# add to group
addtgrp() {
	if [ "$CUR" != "$ROOT" ]; then
		:> "$GROOT"/$2/$1
		showgrp $2
	fi
}

# remove from group
rmvfgrp() {
	if [ "$2" = "all" ]; then
		for grp in "$(seq $GNUM)"; do
			rm -f "$GROOT"/*/$1
		done
	else
		rm -f "$GROOT"/$2/$1
	fi
}

# find group
findgrp() {
	file=$(find "$GROOT" -name "$1")
	[ -n "$file" ] && basename $(dirname $FILE)
}

# show group
showgrp() {
	for file in "$GROOT"/$1/*; do
		wid=$(basename $file)
		mapw -m $wid
	done
	echo + > "$GSTATROOT"/$1
}

# hide group
hidegrp() {
	for file in "$GROOT"/$1/*; do
		wid=$(basename $file)
		mapw -u $wid
	done
	echo - > "$GSTATROOT"/$1
}

# toggle group
tglgrp() {
	wid=$(ls -1 "$GROOT"/$1 | sed 1q)

	[ -z "$wid" ] && return
	wattr m $wid
	if [ $? -eq 0 ]; then
		hidegrp $1
	elif [ $? -eq 1 ]; then
		showgrp $1
	fi
}

# create groups
cgrps() {
	if [ ! -d "$GSTATROOT" ]; then
		mkdir "$GSTATROOT"
	fi
	for gid in $(seq 1 $GNUM ); do
		[ -d "$GROOT"/$gid ] || mkdir -p "$GROOT"/$gid
	done

	for file in $(find "$GROOT" -type f); do
		wid=$(basename $file)
		wattr $wid || rm -f $file
	done

	for gstat in $(seq 1 $GNUM); do
		if [ $(find "$GROOT"/$gstat -maxdepth 0 -type d -empty) ]; then
			echo - > "$GSTATROOT"/$gstat
		fi
	done
}

# print group status
prntstat() {
	echo $(cat "$GSTATROOT"/* | tr '\n' ' ')
}

cgrps

while getopts ":a:d:g:s:t:h:p" opt; do
	case $opt in
		a) addtgrp $CUR $OPTARG ;;
		d) rmvfgrp $CUR $OPTARG ;;
		g) findgrp $CUR ;;
		s) showgrp $OPTARG ;;
		t) tglgrp $OPTARG ;;
		h) hidegrp $OPTARG ;;
		p) prntstat ;;
		*) usage && exit 1 ;;
	esac
done
