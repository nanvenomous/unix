#!/bin/bash
awk='/usr/bin/awk'

confFile="${HOME}/.Xresources"

hr="${HOME}/Scripts/dpi"
script="${hr}/tools/script"

begin_marker='! BEGIN AUTOMATICALLY EDITED PART, DO NOT EDIT'
end_marker='! END AUTOMATICALLY EDITED PART'

new_section="Xft.dpi: ${@}"

export begin_marker end_marker
${awk}\
 -f ${script}\
 -v begin_marker="${begin_marker}"\
 -v end_marker="${end_marker}"\
 -v new_section="${new_section}"\
 <${confFile} >${confFile}