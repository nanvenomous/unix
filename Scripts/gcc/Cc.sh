#!/bin/bash

# grab general script
hr="${HOME}/Scripts/gcc/compileRun.sh"
source ${hr}

comp='/usr/bin/cc'

# check input
if [ $# -eq 0 ]; then
	echo "You must pass in a file to compile and run"
else
	src="${1}"
	compRun comp src
fi