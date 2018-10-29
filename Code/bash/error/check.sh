#!/bin/bash

# errormessage=$( "${@}" 2>&1)
command=$("${@}")

inputs="${@}"

# if [[ $(${inputs}) ]]; then
if [[ ${command} ]]; then
	:
else
	:
#	echo ${errormessage}
fi
