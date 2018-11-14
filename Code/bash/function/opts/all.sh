#!/bin/bash
while [ ! $# -eq 1 ]; do
	case "$1" in
		--help | -h)
			helpmenu
			exit
			;;
		--take-over-world | -t)
			secretopt
			exit
			;;
	esac
	shift
done
