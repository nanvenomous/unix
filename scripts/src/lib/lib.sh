#!/bin/bash

caller="${1}"

function do() {
	"${caller}" "${@}"
}

function doForEach() {
	echo "${@}"
	operation=($1)
	local -n array=$2
	echo ${array[@]}
	for element in "${array[@]}"; do
		${operation} ${element}
	done
}
