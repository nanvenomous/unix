#!/bin/bash

bsh='/bin/bash'
v='/usr/bin/vim'
conf='/.bashrc'

case "$1" in
	"-e")
		command $v $HOME$conf
		command exec $bsh
		;;
	*)
		command $bsh "${@}"
		;;
esac
