#!/bin/bash

# grab general script
hr="${HOME}/Scripts/gcc/compileRun.sh"
source ${hr}

# 2 compiler options
cComp='/usr/bin/cc'
cppComp='/usr/bin/g++'

# variables default to C++ compilation
comp=${cComp}

# Parse options to the `pip` command
while getopts ":hgp" opt; do
	case ${opt} in
		h )
			echo "Usage:"
			echo -e " \t C -h \t\t Display this help message."
			echo -e " \t C -g <file> \t compile for debugging"
			echo -e " \t C -p <file> \t compile c++ code"
			echo -e " \t C <file> \t compile c code."
			exit 0
			;;
		g )
			comp="${cComp} -g"
			;;
		p )
			comp="${cppComp}"
			;;
	 \? )
		 echo "Invalid Option: -$OPTARG" 1>&2
		 exit 1
		 ;;
	esac
done
shift $((OPTIND -1)) # should remove a single option

# if no arguments were passed in
if [[ $# -eq 0 ]] ; then
	# get all c files in directory
	sourceCode="$(find . -name '*.c')"
else # arguments were passed in
	# assume source files to compile passed in
	sourceCode="${@}"
fi

echo "${sourceCode}"

compRun comp sourceCode
