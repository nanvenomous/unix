#!/bin/bash

# grab general script
hr="${HOME}/Scripts/gcc/compileRun.sh"
source ${hr}

cComp='/usr/bin/cc'
cppComp='/usr/bin/g++'

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
			compRun cComp OPTARG
			exit 0
			;;
	 \? )
		 echo "Invalid Option: -$OPTARG" 1>&2
		 exit 1
		 ;;
	esac
done

compRun comp "${@}"