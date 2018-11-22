#!/bin/bash

protected=0
opts=':p'
while getopts ${opts} opt; do
	case ${opt} in
		p ) # for read/write protected files
			protected=1
			;;
		\? )
			echo "Usage: cmd [-p] newSection beginMarker endMarker configFile"
			;;
	esac
done

if [ ${protected} -eq 1 ]; then
	echo 'write protected file'
else
	echo 'non write protected files'
fi
