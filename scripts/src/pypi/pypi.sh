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

# handle case being run from outside pypi directory
check_file="${PWD}/setup.py"
function check_directory() {
	if [ ! -f "${check_file}" ]; then
		echo 'Script must be run in a pypi package directory'
		exit 1
	fi
}

function build() {
	check_directory
	python3.7 setup.py sdist bdist_wheel
}

function clean() {
	check_directory
	rm -r build/*
	rm -r dist/*
	rm -r syspy.egg-info/
}

function init() {
	cp "${comp}/license" "${PWD}"
	cp "${comp}/setup.py" "${PWD}"
}

function pull() {
	echo '[WARNING] If your system claims it is up to date, check the version #.'
	echo 'Sometimes it takes time for the pypi index to update after a push.'
	echo 'Try again after a few seconds: pypi pull <packageName>'
	echo
	sudo -EH pip3 install --upgrade -i https://test.pypi.org/simple/ "${@}"
	echo
	echo 'Congratulations! you deployed a python package.'
	echo 'Push your local git repo to keep everything up to date.'
}

function push() {
	if [ -z "${PYPI_PASSWORD}" ] || [ -z "${PYPI_USERNAME}" ]; then
		echo "[ERROR] must export environment variables for PYPI_USERNAME & PYPI_PASSWORD"
		exit 1;
	fi
	python3.7 -m twine upload -u "${PYPI_USERNAME}" -p "${PYPI_PASSWORD}" --repository-url https://test.pypi.org/legacy/ dist/*
}

function setup() {
	python3.7 -m pip install --user --upgrade setuptools wheel
	python3.7 -m pip install --user --upgrade twine
}

cmd="${1}"; shift # remove package name from the inputs
case "${cmd}" in
	"all")
		check_directory
		read -p "Press enter to change version of the package."
		vim "${check_file}"
		clean
		build
		echo
		echo Cleaned and Built Successfully
		echo
		push
		echo
		echo Successfully pushed to the python test index
		echo
		read -p "Press enter to update your local package. "
		pull "${@}"
		;;
	"build")
		build
		;;
	"clean")
		clean
		;;
	"init")
		init
		;;
	"pull")
		pull "${@}"
		;;
	"push")
		push
		;;
	"setup")
		setup
		;;
	*)
		echo "Not a recognized command: ${cmd}"
		exit 1
		;;

esac
