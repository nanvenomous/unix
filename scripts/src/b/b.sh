#!/bin/bash

# Programs
bsh='/bin/bash'
v='/usr/bin/vim'

# Configuration Files
conf="${HOME}/.bashrc"
platform="${HOME}/.platform.sh"
locConf="${HOME}/.locrc.sh"

# Variables
help=$(cat <<-END
Wrapper for bash command

options
\t-e: edit .bashrc
\t-l: edit .locrc.sh
\t-p: edit .platform.sh
\t-h: help menu
\t-s: exec bash

argument
\tshell script to run
END
)

while getopts ":elphs" opt; do
	case "${opt}" in
		e )
			${v} ${conf}
			exit 0
			;;
		l )
			${v} ${locConf}
			exit 0
			;;
		p )
			${v} ${platform}
			exit 0
			;;
		h ) 
			echo -e "${help}"
			exit 0
			;;
		/? )
			echo -e "Invalid Option: -${OPTARG}"
			exit 1
			;;
	esac
done

${bsh} "${@}"
