#!/bin/bash
hr="${HOME}/Scripts/pypi"
comp="${hr}/components"

function help() {
	echo -e "commands:"
	echo -e "\t build"
	echo -e "\t init"
	echo -e "\t update"
	echo -e "\t upload"
}

case "$1" in
	"build")
		python3.7 setup.py sdist bdist_wheel
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
		python3.7 -m twine upload --repository-url https://test.pypi.org/legacy/ dist/*
		;;
	*)
		echo 'not a recognized command'
		help
		;;
esac
