#!/bin/bash
vim='/usr/bin/vim'
ls='/bin/ls'
outputFile=$HOME'/Scripts/edit/output.txt'
vimCommand=$HOME'/Scripts/edit/command.txt'

command "${@}" > $outputFile

command $vim $outputFile -s $vimCommand
