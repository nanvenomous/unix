#!/bin/bash

hr="${HOME}/Code/bash/file/multiLineEdit"
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
pw="$(${cntlm} -H -a 'NTLMv2' -d 'nam.corp.gm.com' -u "${@}")"

echo "${pw}"

fixed="$(${awk} -f ${pwFix} <(echo ${pw}))"
userName="$(${awk} -f ${getUserName} <(echo ${pw}))"
echo "${userName}"

# NOTE: output must have quotations around it!! ex. "${pwFixed}"
echo "${fixed}"
