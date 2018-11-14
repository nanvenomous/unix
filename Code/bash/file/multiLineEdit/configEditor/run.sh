#!/bin/bash

# get current directory of script
here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

newConfFile="${here}/files/newConfig"
editConfig="${here}/awkScripts/editConfig"
awk='/usr/bin/awk'

touch "${newConfFile}"

new_section="${1}"
begin_marker="${2}"
end_marker="${3}"
confFile="${4}"

export begin_marker end_marker
${awk}\
 -f ${editConfig}\
 -v begin_marker="${begin_marker}"\
 -v end_marker="${end_marker}"\
 -v new_section="${new_section}"\
 <${confFile} >${newConfFile}

mv -f ${newConfFile} ${confFile}
