#!/bin/bash

# grab general script
hr="${HOME}/Scripts/gcc/compileRun.sh"
source ${hr}

# 2 compiler options
cComp='/usr/bin/cc'
cppComp='/usr/bin/g++'

# variables default to C++ compilation
comp=${cppComp}
sourceCode="${@}"

# Parse options to the `pip` command
while getopts ":hc:" opt; do
	case ${opt} in
		h )
			echo "Usage:"
			echo -e " \t C -h \t\t Display this help message."
			echo -e " \t C -c <file> \t compile c code"
			echo -e " \t C <file> \t compile c++ code."
			exit 0
			;;
		c )
			comp="${cComp}"
			echo "${OPTARG}"
			sourceCode="${OPTARG}"
			;;
	 \? )
		 echo "Invalid Option: -$OPTARG" 1>&2
		 exit 1
		 ;;
	esac
done

compRun comp sourceCode
