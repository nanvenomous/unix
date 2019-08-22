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

case "$1" in
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
	"update")
		python3.7 -m pip install --user --upgrade setuptools wheel
		python3.7 -m pip install --user --upgrade twine
		;;
	"upload")
		python3.7 -m twine upload --skip-existing -u 'mrgarelli' -p "${PYPI_PASSWORD}" --repository-url https://test.pypi.org/legacy/ dist/*
		;;
	*)
		echo "Not a recognized command: ${cmd}"
		exit 1
		;;

esac
