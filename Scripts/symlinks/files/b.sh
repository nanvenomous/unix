#!/bin/bash

# Programs
bsh='/bin/bash'
v='/usr/bin/vim'

# Configuration Files
conf="${HOME}/.bashrc"
profile="${HOME}/.profile"
locConf="${HOME}/.locrc"

# Variables
help=$(cat <<-END
Wrapper for bash command

options
\t-e: edit .bashrc
\t-l: edit .locrc
\t-p: edit .profile
\t-h: help menu
\t-s: exec bash

argument
\tshell script to run
END
)

while getopts ":eh" opt; do
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
			${v} ${profile}
			exit 0
			;;
		h ) 
			echo -e "${help}"
			exit 0
			;;
		s )
			exec ${bsh}
			exit 0
			;;
		/? )
			echo -e "Invalid Option: -${OPTARG}"
			exit 1
			;;
	esac
done

${bsh} "${@}"
