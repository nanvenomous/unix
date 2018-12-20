#!/bin/bash

hr="${HOME}/Scripts/dsp"
bash='/bin/bash'

subcommand=$1; shift  # Remove package, command is no longer included in #{@}
case "${subcommand}" in
	"show")
		xrandr | grep -E " connected | disconnected " | awk '{print $1,$2}'
		;;
	"on")
		xrandr --output "${@}" --auto
		;;
	"off")
		xrandr --output "${@}" --off
		;;
	"dpi")
		"${bash}" "${hr}/dpi/run.sh" "${@}"
		;;
	"help")
		echo -e "show\t show monitors available"
		echo -e "on:\t turn on a monitor"
		echo -e "off:\t turn off a monitor"
		echo -e "dpi:\t adjust dpi for all monitors"
		exit
		;;
	*)
		echo 'not a recognized command, for more information type:'
		echo -e "\t> dsp help"
		;;
esac
