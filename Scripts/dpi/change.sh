#!/bin/bash

sudo='/usr/bin/sudo'

hr="${HOME}/Scripts/dpi"
editor="${hr}/tools/edit.sh"

command ${sudo} bash ${editor} "${@}"
command sudo service lightdm restart 
#command xrandr --output HDMI1 --auto