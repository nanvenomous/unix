#!/bin/bash
hr="${HOME}/Scripts/mem"

buildscript='''
buildscript {

    repositories {
        google()
        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.1.3'
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}'''

function init() {
	gradle init
	echo "include ':app'" >> settings.gradle
}

function setup() {
	# author: Matthew Garelli, mgarelli@alumni.stanford.edu
	# Attempting to streamline the android project setup on an Ubuntu system

	# create android projects directory
	mkdir -p "${HOME}/Projects/android"

	echo 'export ANDROID_SDK_HOME="${HOME}/Projects/android"' >> "${HOME}/.profile"

	# install gradle
	sudo apt update
	sudo apt install openjdk-8-jdk

	sudo apt-get update
	sudo apt-get install gradle
}
