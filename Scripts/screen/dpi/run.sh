#!/bin/bash

sudo='/usr/bin/sudo'
bash='/bin/bash'

hr="${HOME}/Scripts/dpi"

# function to auto edit config based on
# 	delimiters
# 	file path
# 	packetized editor based on awk
function replaceInConfig () {
	${bash} ${configEditor}\
	 "${new_section}"\
	 "${begin_marker}"\
	 "${end_marker}"\
	 "${confFile}"

}
configEditor="${hr}/configEditor/run.sh"

# __________________________________________________ config file dpi

confFile="${HOME}/.Xresources"

new_section="Xft.dpi: ${@}"
begin_marker='! BEGIN DPI AUTOMATICALLY EDITED PART, DO NOT EDIT'
end_marker='! END AUTOMATICALLY EDITED PART'

replaceInConfig

command sudo service lightdm restart 
#command xrandr --output HDMI1 --auto
