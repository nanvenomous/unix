#!/bin/bash

command "${@}" &>/dev/null

if [[ $? != 0 ]]; then
	echo "failure"
else
	echo "success"
fi
