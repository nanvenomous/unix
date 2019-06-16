# author: Matthew Garelli, mgarelli@alumni.stanford.edu
# Attempting to streamline the android project setup on an Ubuntu system

#!/bin/bash

projectdir="${HOME}/Projects/android"
hr="${HOME}/Scripts/android"
rsrc="${hr}/rsrc"
buildscript="${rsrc}/buildscript.txt"
appBuildFile='./app/build.gradle'

function init() {
	gradle init
	echo "include ':app'" >> settings.gradle
	cat "${buildscript}" >> './build.gradle'

	mkdir -p ./app
	touch "${appBuildFile}"
	cat "${HOME}/Scripts/android/rsrc/app_buildscript.txt" >> "${appBuildFile}"
}

function setup() {
	mkdir -p "${projectdir}" # create android projects directory

	echo 'export ANDROID_SDK_HOME="${HOME}/Projects/android"' >> "${HOME}/.profile"

	# install gradle
	sudo apt update
	sudo apt install openjdk-8-jdk

	sudo apt-get update
	sudo apt-get install gradle
}
