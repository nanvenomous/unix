#!/bin/bash

while getopts ":hiw" opt; do
	case ${opt} in
		h )
			echo "Usage:"
			echo -e " \t -h \t\t Display this help message."
			echo -e " \t -w <file> \t folders that contain files with string"
			exit 0
			;;
		i )
			# finds files with the argument inside the file
			# appears to be case insentive
			find . -type f -print | xargs grep "${@}"
			exit 0;
			;;
		w )
			# returns all folders: containing filename containing the argument
			shift;
			find . -type f -name "${@}" | sed -r 's|/[^/]+$||' |sort |uniq
			exit 0;
			;;
	 \? )
		 echo "Invalid Option: -$OPTARG" 1>&2
		 exit 1
		 ;;
	esac
done

find . -name "*${@}*"
