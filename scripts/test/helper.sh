#!/bin/bash
# this is the example helper

caller="${1}"

function do() {
	"${caller}" "${@}"
}

function apiExample() {
	echo "${1}"
	"${1}"
}
