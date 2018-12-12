#!/bin/bash

generalGitWrapper () {
	# gather inputs
	local -n cmdRef=$1
	local allInputs="${@:2}"
	local shortcut=$2
	local restOfInputs="${@:3}"

	# wrapper for shortcuts
	case "$shortcut" in
		"a")
			cmdRef="$cmdRef add ${restOfInputs}"
			;;
		"b")
			cmdRef="$cmdRef branch ${restOfInputs}"
			;;
		"c")
			cmdRef="$cmdRef commit ${restOfInputs}"
			;;
		"ch")
			cmdRef="$cmdRef checkout ${restOfInputs}"
			;;
		"chb")
			cmdRef="$cmdRef checkout -b ${restOfInputs}"
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
		"ph")
			cmdRef="$cmdRef push ${restOfInputs}"
			;;
		"plr")
			cmdRef="$cmdRef pull --rebase ${restOfInputs}"
			;;
		"r")
			cmdRef="$cmdRef remote ${restOfInputs}"
			;;
		"ra")
			cmdRef="$cmdRef remote add ${restOfInputs}"
			;;
		"rma")
			cmdRef="$cmdRef rm -r --cached . ${restOfInputs}"
			;;
		"rs")
			cmdRef="$cmdRef remote show ${restOfInputs}"
			;;
		"s")
			cmdRef="$cmdRef status ${restOfInputs}"
			;;
		"t")
			cmdRef="$cmdRef ls-tree -r --name-only ${restOfInputs}"
			;;
		"hh")
			echo -e "a:\tadd"
			echo -e "aa:\tadd ."
			echo -e "b:\tbranch"
			echo -e "c:\tcommit"
			echo -e "ch:\tcheckout"
			echo -e "chb:\tcheckout -b"
			echo -e "i:\tinit"
			echo -e "l:\tlog"
			echo -e "m:\tmerge"
			echo -e "ph:\tpush"
			echo -e "plr:\tpull --rebase"
			echo -e "r:\tremote"
			echo -e "ra:\tremote add"
			echo -e "rma:\trm -r --cached ."
			echo -e "rs:\tremote show"
			echo -e "s:\tstatus"
			echo -e "t:\tls-tree -r --name-only"
			exit
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
