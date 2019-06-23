#!/bin/bash

bsh='/bin/bash'
v='/usr/bin/vim'
conf="${HOME}/.bashrc"
profile="${HOME}/.profile"
locConf="${HOME}/.locrc"

case "${1}" in
	"-e")
		${v} ${conf}
		;;
	"-el")
		${v} ${locConf}
		;;
	"-ep")
		${v} ${profile}
		;;
	"-s")
		exec ${bsh}
		;;
	*)
		${bsh} "${@}"
		;;
esac
