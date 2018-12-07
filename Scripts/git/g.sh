#!/bin/bash
source ${HOME}/Scripts/git/general.sh

g='/usr/bin/git'
cmd="${g}"


case "$1" in
	"aa")
		# stage manually deleted or moved files
		stageManualChanges cmd
		# add/stage changes in all configuration files
		command $cmd add .
		;;
	*)
		generalGitWrapper cmd "${@}"
		command $cmd
		;;
esac
