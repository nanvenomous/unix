#!/bin/bash
hr="${HOME}/scripts/src/dsk"
help="${hr}/help"

function list() {
	# list all drives discluding swap
	lsblk | grep -v -e 'SWAP' -e 'loop'
}

while getopts ":h" opt; do
	case "${opt}" in
		h ) 
			cat "${help}"
			exit 0
			;;
		\? )
			echo "Invalid Option: -${OPTARG}"
			exit 1
			;;
	esac
done
shift $((OPTIND -1)) # remove the package flag

cmd="${1}"; shift # remove rn from the arguments
case "${cmd}" in
	l )
		list
		;;
	* )
		cat "${help}"
		;;
esac

