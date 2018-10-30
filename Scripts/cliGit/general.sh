#!/bin/bash

generalGitWrapper () {
	# gather inputs
	local -n cmdRef=$1
	local allInputs="${@:2}"
	local shortcut=$2
	local restOfInputs="${@:3}"

	# wrapper for shortcuts
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
stageManualChanges () {
	local -n cmdRef=$1
	command ${cmdRef} rm $(${cmdRef} ls-files --deleted) &>/dev/null
	command ${cmdRef} add -u
}
