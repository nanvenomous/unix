#!/bin/bash
awk='/usr/bin/awk'

hr="${HOME}/Code/bash/file/internalEdit"
confFile="${hr}/conf/toEdit.txt"
newConfFile="${hr}/conf/test.txt"
script="${hr}/script"

begin_marker='# BEGIN AUTOMATICALLY EDITED PART, DO NOT EDIT'
end_marker='# END AUTOMATICALLY EDITED PART'

new_section="someVariable=${1}"

export begin_marker end_marker
${awk}\
 -f ${script}\
 -v begin_marker="${begin_marker}"\
 -v end_marker="${end_marker}"\
 -v new_section="${new_section}"\
 <${confFile} >${newConfFile}

mv -f ${newConfFile} ${confFile}