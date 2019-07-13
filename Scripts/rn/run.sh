#!/bin/bash
# Directories
hr="${HOME}/Scripts/rn"
rsrc="${hr}/rsrc"
text="${hr}/text"

# Files
linter="${rsrc}/eslintrc"
readme="${rsrc}/readme.md"
rdm="${rsrc}/rdm"
help="${text}/help"

function documentationMigration() {
	echo 'copying readme'
	cp "${readme}" "${PWD}"
	echo 'copying .rdm folder'
	cp -r "${rdm}" "${PWD}/.rdm"
}

function linterInstallation() {
	echo 'installing eslint'
	npm install eslint
	echo 'installing rallycoding'
	npm install --save-dev eslint-config-rallycoding
	echo 'moving .eslintrc'
	cp "${linter}" "${PWD}/.eslintrc"
	echo 'NOTE: still need eslint extension in your editor'
}

function runProject() {
	react-native run-android
}

function setupReactNative() {
	sudo apt install nodejs npm
	sudo apt install npm
	sudo npm install -g react-native-cli
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update
	sudo apt install oracle-java8-installer
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
shift $((OPTIND -1)) # remove the package flag

# Handle case no arguments
if [[ $# -eq 0 ]] ; then
	cat "${help}"
	exit 0
fi

cmd="${1}"; shift # remove rn from the arguments
case "${cmd}" in
	docs )
		documentationMigration
		;;
	lint )
		linterInstallation
		;;
	r )
		runProject
		;;
	setup )
		setupReactNative
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		;;
esac

