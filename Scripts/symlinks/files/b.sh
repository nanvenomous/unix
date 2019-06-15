#!/bin/bash

bsh='/bin/bash'
v='/usr/bin/vim'
conf="${HOME}/.bashrc"
locConf="${HOME}/.locrc"

case "${1}" in
	"-e")
		${v} ${conf}
		;;
	"-el")
		${v} ${locConf}
		;;
	"-s")
		exec ${bsh}
		;;
	*)
		${bsh} "${@}"
		;;
esac
