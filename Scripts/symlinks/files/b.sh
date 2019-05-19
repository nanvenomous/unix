#!/bin/bash

bsh='/bin/bash'
v='/usr/bin/vim'
conf="${HOME}/.bashrc"
locConf="${HOME}/.locrc"

case "${1}" in
	"-e")
		${v} ${conf}
		exec ${bsh}
		;;
	"-el")
		${v} ${locConf}
		exec ${bsh}
		;;
	*)
		${bsh} "${@}"
		;;
esac
