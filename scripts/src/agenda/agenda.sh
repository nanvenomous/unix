#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

chrome='/usr/bin/chromium-browser'
agenda="${hr}/agenda.md"
help="${hr}/help"

function editAgendaSource() {
	vim ${agenda}
}

while getopts ":he" opt; do
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
	e )
		editAgendaSource
		;;
	v )
		${chrome} ${agenda} &>/dev/null
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		exit 1
		;;
esac

