#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

comp="${hr}/components"
help="${hr}/help"

pwd="${PYPI_PASSWORD}"

check_file="${PWD}/setup.py"
if [ ! -f "${check_file}" ]; then
	echo 'Script must be run in a pypi package directory'
	exit 1
fi

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

function check_root() {
	if [[ $EUID -ne 0 ]]; then
		echo "This script must be run as root" 
		exit 1
	fi
}

function build() {
	python3.7 setup.py sdist bdist_wheel
}

function clean() {
	rm -r build/*
	rm -r dist/*
	rm -r syspy.egg-info/
}

function init() {
	cp "${comp}/license" "${PWD}"
	cp "${comp}/setup.py" "${PWD}"
}

function pull() {
	sudo -E pip3 install --upgrade -i https://test.pypi.org/simple/ "${@}"
}

function push() {
	python3.7 -m twine upload -u 'mrgarelli' -p "${pwd}" --repository-url https://test.pypi.org/legacy/ dist/*
}

function setup() {
	python3.7 -m pip install --user --upgrade setuptools wheel
	python3.7 -m pip install --user --upgrade twine
}

cmd="${1}"; shift # remove package name from the inputs
case "${cmd}" in
	"all")
		read -p "Press enter to change version of the package."
		vim "${check_file}"
		clean
		build
		push
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
