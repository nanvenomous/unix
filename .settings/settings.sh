#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

chrome='/usr/bin/chromium-browser'
help="${hr}/help"
configurations="${hr}/configurations.sh"
installs="${hr}/installs.sh"

shortcuts="${hr}/shortcuts.md"
readme="${hr}/readme.md"

function render_in_browser() {
	"${chrome}" "${@}" &>/dev/null
}

function view_in_editor() {
	vim "${@}"
}

operation='render_in_browser'

opts=':he'
while getopts ${opts} opt; do
	case ${opt} in
		h ) 
			cat "${help}"
			exit 0
			;;
		e ) # for read/write protected files
			operation='view_in_editor'
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

cmd="${1}"; shift # remove package from the arguments
case "${cmd}" in
	c )
		bash "${configurations}"
		;;
	d )
		("${operation}" "${readme}")
		;;
	i )
		bash "${installations}"
		;;
	s )
		("${operation}" "${shortcuts}")
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		;;
esac
