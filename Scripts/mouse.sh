#!/bin/bash

# Below gets id=### from xinput
id="$(xinput | grep 'DLL07BE:01 06CB:7A13 Touchpad' | awk '{print $6}')"
# next we remove the id= part to just get 11
id="${id/'id='/}"

case "$1" in
	"on")
		command xinput enable ${id} "${@:2}"
		;;
	"off")
		command xinput disable ${id} "${@:2}"
		;;
esac
