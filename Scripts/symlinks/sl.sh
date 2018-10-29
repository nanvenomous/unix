#!/bin/bash

ln='/bin/ln'
chmod='/bin/chmod'

#__________________________________________________ Updating a Symlink
function link() {
	file=${1}
	link=${2}
	command sudo ${ln} -s ${file} ${link}
	command ${chmod} +x ${file}
	echo -e "\t" link created
}

function relink() {
	file=${1}
	link=${2}
	command sudo ${ln} -sf ${file} ${link}
	command ${chmod} +x ${file}
	echo -e "\t" link updated
}

#__________________________________________________ Looping Through Each File

# must be global
filePath="${PWD}/files/"

# user executable directory
exeDir='/usr/local/bin/'

array=(${filePath}*)

function forEachSymLink() {
	operation=($1)
	for file in "${array[@]}"; do   # The quotes are necessary here
		link="${file/${filePath}/${exeDir}}"
		link="${link/%.*/}"
		echo "${file} --> ${link}"
		${operation} ${file} ${link}
	done
}

#__________________________________________________ Actions

case "$1" in
	"link")
		forEachSymLink link
		;;
	"relink")
		forEachSymLink relink
		;;
	*)
		echo commands:
		echo -e "\t" link
		echo -e "\t" relink
		echo -e "\t" unlink
		;;
esac
