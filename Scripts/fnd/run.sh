#!/bin/bash

while getopts ":hw" opt; do
	case ${opt} in
		h )
			echo "Usage:"
			echo -e " \t -h \t\t Display this help message."
			echo -e " \t -w <file> \t folders that contain files with string"
			exit 0
			;;
		w )
			# find all folders containing file with the string passed in
			shift;
			find . -type f -name "${@}" | sed -r 's|/[^/]+$||' |sort |uniq
			exit;
			;;
	 \? )
		 echo "Invalid Option: -$OPTARG" 1>&2
		 exit 1
		 ;;
	esac
done

find . -name "*${@}*"
