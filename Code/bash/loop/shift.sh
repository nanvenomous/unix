#!/bin/bash
# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

# GetOpts parsing example
#	input string:
#		":ht" disables default error handling
#		"h:t" indicates the -h flag takes an argument

while getopts ":ht:" opt; do
	case ${opt} in
		h ) # process option a
			echo 'this is the help menu'
			;;
		t ) # process option t
			echo ${OPTARG}
			;;
		\? ) echo "Usage: cmd [-h] [-t]"
			;;
	esac
done
