#!/bin/bash

hr="${HOME}/Code/bash/file/multiLineEdit"

# ____________________________________________________________ cntlm wrapper
pwFix="${hr}/awkScripts/pwFix"
getUserName="${hr}/awkScripts/getUserName"

cntlm='/usr/sbin/cntlm'
awk='/usr/bin/awk'

# Check for imput arguments
if [ $# -eq 0 ]; then
	echo 'Must enter a username to authenticate'
	exit 1
fi

echo 'Enter Password:'
cntlmOut="$(${cntlm} -H -a 'NTLMv2' -d 'nam.corp.gm.com' -u "${@}")"

pw="$(${awk} -f ${pwFix} <(echo ${cntlmOut}))"
userName="$(${awk} -f ${getUserName} <(echo ${cntlmOut}))"
userName="${userName/\'/}"
echo "${userName}"

# NOTE: output must have quotations around it!! ex. "${pw}"
echo "${pw}"

# ____________________________________________________________ config file
confFile="${hr}/conf/toEdit.txt"
newConfFile="${hr}/conf/test.txt"
script="${hr}/script"

begin_marker='# Password BEGIN AUTOMATICALLY EDITED PART, DO NOT EDIT'
end_marker='# Password END AUTOMATICALLY EDITED PART'

new_section="someVariable=${1}"

