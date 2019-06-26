# author: Matthew Garelli, mgarelli@alumni.stanford.edu
# Attempting to streamline the android project setup on an Ubuntu system

#!/bin/bash

projectdir="${HOME}/Projects/android"
sdk="${projectdir}/sdk"
hr="${HOME}/Scripts/android"
rsrc="${hr}/rsrc"
buildscript="${rsrc}/buildscript.txt"
stylesheet="${rsrc}/styles.xml"
androidManifest="${rsrc}/AndroidManifest.xml"

appBuildFile='./app/build.gradle'
mainFolder='./app/src/main/'
styleFolder='./app/src/main/res/values'



function init() {
	gradle init
	echo "include ':app'" >> settings.gradle
	cat "${buildscript}" >> './build.gradle'

	mkdir -p ./app
	touch "${appBuildFile}"
	cat "${HOME}/Scripts/android/rsrc/app_buildscript.txt" >> "${appBuildFile}"

	mkdir -p "${styleFolder}"
	cp "${stylesheet}" "${styleFolder}"
	cp "${androidManifest}" "${mainFolder}"
}

function setup() {

	# android sdk
	mkdir "${HOME}/.android/avd"
	mkdir -p "${projectdir}" # create android projects directory
	mkdir -p "${sdk}" # for the sdk
	# TODO: actually download the sdk, lol
	sudo "${sdk}/tools/bin/sdkmanager" --licenses

	# install java
	sudo apt update
	sudo apt install openjdk-8-jdk

	# install gradle
	curl -s "https://get.sdkman.io" | bash
	source "${HOME}/.sdkman/bin/sdkman-init.sh"
	sdk install gradle
}
