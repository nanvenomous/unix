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

# Handle case no arguments
if [[ $# -eq 0 ]] ; then
	cat "${help}"
	exit 0
fi

cmd="${1}"; shift # remove the package from the arguments
case "${cmd}" in
	l )
		list
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		exit 1
		;;
esac

