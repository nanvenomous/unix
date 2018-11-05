#!/bin/bash
# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

while getopts ":ht" opt; do
	case ${opt} in
		h ) # process option a
			echo ${OPTARG}
			;;
		t ) # process option t
			echo ${2}
			;;
		\? ) echo "Usage: cmd [-h] [-t]"
			;;
	esac
done
