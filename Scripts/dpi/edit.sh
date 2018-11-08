#!/bin/bash

vim='/usr/bin/vim'
file="${HOME}/.Xresources"
cmd="${HOME}/Scripts/dpi/commands.txt"

command ${vim} ${file} -s ${cmd}
command sudo service lightdm restart
command xrandr --output HDMI1 --auto
