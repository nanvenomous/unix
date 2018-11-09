#!/bin/bash

hr="${HOME}/Code/bash/file/internalEdit"
confFile="${hr}/toEdit.txt"
script="${hr}/script"

begin_marker='# BEGIN AUTOMATICALLY EDITED PART, DO NOT EDIT'
end_marker='# END AUTOMATICALLY EDITED PART'

new_section="someVariable=${1}"

export begin_marker end_marker
awk -f ${script} -v begin_marker="${begin_marker}" -v end_marker="${end_marker}" -v new_section="${new_section}" ${confFile}

#ln -f file.conf file.conf.old
#mv -f file.conf.new file.conf