#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

help="${hr}/help"

function cloneToUSB() {
	# ${1} is the partition
	# ${2} is the file
	sudo partclone.ext4 -c -d -s "${1}" | gzip -c5 > "${2}".img.gz
}

function restoreToPartition() {
	# ${1} is the file
	# ${2} is the partition
	zcat "${1}" | sudo partclone.ext4 -r -o "${2}"
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
shift $((OPTIND -1)) # remove the package flag (if exists)

# Handle case no arguments
if [[ $# -eq 0 ]] ; then
	cat "${help}"
	exit 0
fi

cmd="${1}"; shift # remove the package from the arguments
case "${cmd}" in
	clone )
		cloneToUSB
		;;
	restore)
		restoreToPartition
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		exit 1
		;;
esac
