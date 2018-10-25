#!/bin/bash
vim='/usr/bin/vim'
ls='/bin/ls'
outputFile=$HOME'/Scripts/edit/output.txt'
vimCommand=$HOME'/Scripts/edit/command.txt'

case "$1" in
	"here")
		command echo $PWD > $outputFile
		;;
	*)
		command "${@}" > $outputFile
		;;
esac

command $vim $outputFile -s $vimCommand
