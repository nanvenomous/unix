#!/bin/bash

function echoUsage () {
	echo "Usage: cmd [-h] [-t]"
}

# allows for the options -h, -t, -a
opts=':hc:-'
while getopts ${opts} opt; do
	case ${opt} in
		- )
			echo ${OPTARG}
			;;
		h )
			;;
		t )
			;;
		\? )
			echo "Usage: cmd [-h] [-t]"
			;;
	esac
done

# https://stackoverflow.com/questions/402377/using-getopts-in-bash-shell-script-to-get-long-and-short-command-line-options
