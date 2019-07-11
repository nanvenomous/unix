#!/bin/bash
hr="${HOME}/Scripts/rn"
rsrc="${hr}/rsrc"
linter="${rsrc}/eslintrc"
readme="${rsrc}/readme.md"
rdm="${rsrc}/rdm"

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

function setup() {
	sudo apt install nodejs npm
	sudo apt install npm
	sudo npm install -g react-native-cli
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update
	sudo apt install oracle-java8-installer
}
