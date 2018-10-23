#!/bin/bash

g='/usr/bin/git'
config="--git-dir=${HOME}/.cfg --work-tree=${HOME}"
cmd="${g} ${config}"

generalGitWrapper () {
	local -n cmdRef=$1
	local allInputs="${@:2}"
	local shortcut=$2
	local restOfInputs="${@:3}"

	case "$shortcut" in
		"b")
			cmdRef="$cmdRef branch ${restOfInputs}"
			;;
		"c")
			cmdRef="$cmdRef commit ${restOfInputs}"
			;;
		"ch")
			cmdRef="$cmdRef checkout ${restOfInputs}"
			;;
		"i")
			cmdRef="$cmdRef init ${restOfInputs}"
			;;
		"l")
			cmdRef="$cmdRef log ${restOfInputs}"
			;;
		"m")
			cmdRef="$cmdRef merge ${restOfInputs}"
			;;
		"p")
			cmdRef="$cmdRef push ${restOfInputs}"
			;;
		"r")
			cmdRef="$cmdRef remote ${restOfInputs}"
			;;
		"s")
			cmdRef="$cmdRef status ${restOfInputs}"
			;;
		"t")
			cmdRef="$cmdRef ls-tree -r --name-only ${restOfInputs}"
			;;
		"chb")
			cmdRef="$cmdRef checkout -b ${restOfInputs}"
			;;
		"pr")
			cmdRef="$cmdRef pull --rebase ${restOfInputs}"
			;;
		"rs")
			cmdRef="$cmdRef remote show ${restOfInputs}"
			;;
		*)
			cmdRef="$cmdRef ${allInputs}"
			;;
	esac

}

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
