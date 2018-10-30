#!/bin/bash

ln='/bin/ln'
chmod='/bin/chmod'

#__________________________________________________ Updating a Symlink
function link() {
	file=${1}
	link=${2}
	command ${chmod} +x ${file}

	command sudo ${ln} -s ${file} ${link} &>/dev/null
	if [[ $? != 0 ]]; then
		echo -e "\t link already existed, use relink to update"
	else
		echo -e "\t link created"
	fi
}

function relink() {
	file=${1}
	link=${2}
	command sudo ${ln} -sf ${file} ${link}
	command ${chmod} +x ${file}
	echo -e "\t link updated"
}

function unlink() {
	file=${1}
	link=${2}

	command sudo unlink ${link} &>/dev/null

	if [[ $? != 0 ]]; then
		echo -e "\t link never existed"
	else
		echo -e "\t link destroyed"
	fi
}

function check() {
	(cd /usr/bin && tree -la | grep "── ${1} ->")
	(cd /usr/bin && tree -la | grep "├── ${1}$")
	(cd /usr/local/bin && tree -la | grep "── ${1} ->")
	(cd /usr/local/bin && tree -la | grep "├── ${1}$")
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
	"unlink")
		forEachSymLink unlink
		;;
	"check")
		check ${2}
		;;
	*)
		echo commands:
		echo -e "\t" link
		echo -e "\t" relink
		echo -e "\t" unlink
		echo -e "\t" check
		;;
esac
