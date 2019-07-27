#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

help="${hr}/help"

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

cmd="${1}"; shift # remove package from the arguments
case "${cmd}" in
	"on")
		xinput enable 'DLL07BE:01 06CB:7A13 Touchpad'
		;;
	"off")
		xinput disable 'DLL07BE:01 06CB:7A13 Touchpad'
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		;;
esac
