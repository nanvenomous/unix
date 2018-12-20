#!/bin/bash
vim='/usr/bin/vim'
ls='/bin/ls'
outputFile=$HOME'/Scripts/edit/output.txt'
vimCommand=$HOME'/Scripts/edit/scriptVim'

command "${@}" > $outputFile

command $vim $outputFile -s $vimCommand
