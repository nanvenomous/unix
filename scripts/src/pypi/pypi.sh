#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

comp="${hr}/components"
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

cmd="${1}"; shift # remove package name from the inputs
case "${cmd}" in
	"build")
		python3.7 setup.py sdist bdist_wheel
		;;
	"clean")
		rm -r build/*
		rm -r dist/*
		rm -r syspy.egg-info/
		;;
	"init")
		cp "${comp}/license" "${PWD}"
		cp "${comp}/setup.py" "${PWD}"
		;;
	"pull")
		pip3 install --upgrade -i https://test.pypi.org/simple/ "${@}"
		;;
	"push")
		python3.7 -m twine upload -u 'mrgarelli' -p "${PYPI_PASSWORD}" --repository-url https://test.pypi.org/legacy/ dist/*
		;;
	"setup")
		python3.7 -m pip install --user --upgrade setuptools wheel
		python3.7 -m pip install --user --upgrade twine
		;;
	*)
		echo "Not a recognized command: ${cmd}"
		exit 1
		;;

esac
