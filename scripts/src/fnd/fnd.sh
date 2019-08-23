#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

help="${hr}/help"


while getopts ":hiow" opt; do
	case ${opt} in
		h )
			cat "${help}"
			exit 0
			;;
		i )
			# finds files with the argument inside the file
			# appears to be case insentive
			find . -type f -print | xargs grep "${@}"
			exit 0;
			;;
		o )
			# finds files/dirs one level deep
			t | grep -i "${@}"
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
