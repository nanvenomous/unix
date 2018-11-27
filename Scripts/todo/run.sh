#!/bin/bash

chrome='/usr/bin/chromium-browser'
agenda="${HOME}/Scripts/todo/agenda.md"

opts=':e'
while getopts ${opts} opt; do
	case ${opt} in
		e ) # for read/write protected files
			vim ${agenda}
			exit
			;;
		\? )
			echo "Usage: cmd [-e]"
			;;
	esac
	shift
done

${chrome} ${agenda} &>/dev/null
