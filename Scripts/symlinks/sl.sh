#!/bin/bash

ln='/bin/ln'
chmod='/bin/chmod'

#__________________________________________________ Updating a Symlink
function relink() {
	file=${1}
	link=${2}
	command sudo ${ln} -sf ${file} ${link}
	command ${chmod} +x ${file}
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

forEachSymLink relink
