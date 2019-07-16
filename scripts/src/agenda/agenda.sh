#!/bin/bash
hr="${HOME}/scripts/src/agenda"

chrome='/usr/bin/chromium-browser'
agenda="${hr}/agenda.md"

function editAgendaSource() {
	vim ${agenda}
}

while getopts ":he" opt; do
	case "${opt}" in
		h ) 
			cat "${help}"
			exit 0
			;;
		e )
			editAgendaSource
			exit 0
			;;
		\? )
			echo "Invalid Option: -${OPTARG}"
			exit 1
			;;
	esac
done
shift $((OPTIND -1)) # remove the package flag (if exists)

${chrome} ${agenda} &>/dev/null
