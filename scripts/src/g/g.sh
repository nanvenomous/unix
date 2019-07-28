#!/bin/bash
hr="$( dirname "$( realpath "${0}" )" )"

addAllConfigFiles="${hr}/addAllConfigFiles.sh"
help="${hr}/help"

cmd='/usr/bin/git'
config='false'

stageManualChanges () {
	local -n cmdRef=$1
	command ${cmdRef} rm $(${cmdRef} ls-files --deleted) &>/dev/null
	command ${cmdRef} add -u
}

while getopts ":hc" opt; do
	case "${opt}" in
		c ) 
			cmd="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"
			config='true'
			;;
		h ) 
			cat "${help}"
			exit 0
			;;
		\? )
			echo "Invalid Option: -${OPTARG}"
			exit 1
			;;
	esac
done
shift $((OPTIND -1)) # remove the package flag (if exists)

# Handle case no arguments
if [[ $# -eq 0 ]] ; then
	cat "${help}"
	exit 0
fi


# gather inputs
shortcut="${1}"
inputs="${@:2}"

# wrapper for shortcuts
case "$shortcut" in
	"a")
		cmd="$cmd add ${inputs}"
		;;
	"aa")

		# stage manually deleted or moved files
		stageManualChanges cmd
		if [[ "${config}" -eq 'true' ]] ; then
			bash "${addAllConfigFiles}" "${cmd}"
		else
			# add/stage changes in all configuration files
			command $cmd add .
		fi
		exit 0
		;;
	"b")
		cmd="$cmd branch ${inputs}"
		;;
	"c")
		cmd="$cmd commit ${inputs}"
		;;
	"ca")
		cmd="$cmd commit --amend ${inputs}"
		;;
	"ch")
		cmd="$cmd checkout ${inputs}"
		;;
	"chb")
		cmd="$cmd checkout -b ${inputs}"
		;;
	"i")
		cmd="$cmd init ${inputs}"
		;;
	"l")
		cmd="$cmd log ${inputs}"
		;;
	"m")
		cmd="$cmd merge ${inputs}"
		;;
	"ph")
		cmd="$cmd push ${inputs}"
		;;
	"pl")
		cmd="$cmd pull ${inputs}"
		;;
	"plr")
		cmd="$cmd pull --rebase ${inputs}"
		;;
	"r")
		cmd="$cmd remote ${inputs}"
		;;
	"ra")
		cmd="$cmd remote add ${inputs}"
		;;
	"rma")
		cmd="$cmd rm -r --cached . ${inputs}"
		;;
	"rs")
		cmd="$cmd remote show ${inputs}"
		;;
	"s")
		cmd="$cmd status ${inputs}"
		;;
	"t")
		cmd="$cmd ls-tree -r --name-only ${inputs}"
		;;
	*)
		# to run anything not just the shortcuts
		# cmd="$cmd ${allInputs}"
		echo "Not a recognized command: ${shortcut}"
		exit 1
		;;
esac

command ${cmd}