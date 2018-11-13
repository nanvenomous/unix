#!/bin/bash

# get current directory of script
hr="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

newConfFile="${hr}/files/newConfig"
editConfig="${hr}/awkScripts/editConfig"
awk='/usr/bin/awk'

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
			confFile="${OPTARG}"
			;;
	 \? )
		 echo "Invalid Option: -$OPTARG" 1>&2
		 exit 1
		 ;;
	esac
done
shift $((OPTIND -1)) # should remove a single option

new_section="${1}"
begin_marker="${2}"
end_marker="${3}"

export begin_marker end_marker
${awk}\
 -f ${editConfig}\
 -v begin_marker="${begin_marker}"\
 -v end_marker="${end_marker}"\
 -v new_section="${new_section}"\
 <${confFile} >${newConfFile}

mv -f ${newConfFile} ${confFile}
