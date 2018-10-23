#!/bin/bash
source ./general.sh

g='/usr/bin/git'
config="--git-dir=${HOME}/.cfg --work-tree=${HOME}"
cmd="${g} ${config}"


case "$1" in
	"aa")
		# stage manually deleted or moved files
		command $cmd rm -q $($cmd ls-files --deleted) &>/dev/null
		# add/stage changes in all configuration files
		command $cmd add ${HOME}/.README.md
		command $cmd add ${HOME}/.bashrc
		command $cmd add ${HOME}/.vimrc
		command $cmd add ${HOME}/.xinitrc
		command $cmd add ${HOME}/Scripts/*
		;;
	*)
		generalGitWrapper cmd "${@}"
		command $cmd
		;;
esac
