#!/bin/bash

chrome='/usr/bin/chromium-browser'
hr="${HOME}/.settings"
settings="${hr}/settings.md"

opts=':e'
while getopts ${opts} opt; do
	case ${opt} in
		e ) # for read/write protected files
			vim ${settings}
			exit
			;;
		\? )
			echo "Usage: cmd [-e]"
			;;
	esac
	shift
done

${chrome} ${settings} &>/dev/null
