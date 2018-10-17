#!/bin/bash

case "$1" in
	"on")
		command xinput enable 11 "${@:2}"
		;;
	"off")
		command xinput disable 11 "${@:2}"
		;;
esac
