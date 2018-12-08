#!/bin/bash

bsh='/bin/bash'
v='/usr/bin/vim'
conf="${HOME}/.bashrc"
locConf="${HOME}/.locrc"

case "$1" in
	"-e")
		command ${v} ${conf}
		command exec ${bsh}
		;;
	"-el")
		command ${v} ${locConf}
		command exec ${bsh}
		;;
	*)
		command $bsh "${@}"
		;;
esac
