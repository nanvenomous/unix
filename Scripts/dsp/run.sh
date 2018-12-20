#!/bin/bash

subcommand=$1; shift  # Remove package, command is no longer included in #{@}
case "${subcommand}" in
	"show")
		xrandr | grep -E " connected | disconnected " | awk '{print $1,$2}'
		;;
	"off")
		xrandr --output "${@}" --off
		;;
	"on")
		xrandr --output "${@}" --auto
		;;
	"help")
		echo -e "show\t show monitors available"
		echo -e "on:\t turn on a monitor"
		echo -e "off:\t turn off a monitor"
		exit
		;;
	*)
		echo 'not a recognized command, for more information type:'
		echo -e "\t> dsp help"
		;;
esac
