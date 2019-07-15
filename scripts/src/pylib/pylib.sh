#!/bin/bash

hr="${HOME}/scripts/src/pylib"
help="${hr}/help"

function sysPython() {
	python3 -c "import sys; sys.path.insert(0, '${hr}'); ${@}"
}

function callPythonFunctionFromScript() {
	# take a script and a method, runs the method from the python script
	script="${1}"
	location=$(dirname "${script}")
	file=$(basename "${script}")
	method="${2}"
	# use the syspy tool to call a python function
	sysPython "from tools import functionFromScript; \
	functionFromScript('${location}', '${file}', '${method}')"
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

cmd="${1}"; shift # remove package from the arguments
case "${cmd}" in
	caller )
		callPythonFunctionFromScript "${@}"
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		;;
esac
