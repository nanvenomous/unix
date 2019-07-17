#!/bin/bash

#__________________________________________________ handle flags
protected=0
opts=':p'
while getopts ${opts} opt; do
	case ${opt} in
		p ) # for read/write protected files
			protected=1
			;;
		\? )
			echo "Usage: cmd [-p] newSection beginMarker endMarker configFile"
			;;
	esac
	shift
done

#__________________________________________________ initialize variables
# get current directory of script
here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

newConfFile="${here}/files/newConfig"
oldConfFile="${here}/files/oldConfig"
editConfig="${here}/awkScripts/editConfig"
awk='/usr/bin/awk'

new_section="${1}"
begin_marker="${2}"
end_marker="${3}"
confFile="${4}"

#__________________________________________________ awk editing / file manipulation
export begin_marker end_marker

mkdir -p "${here}/files/"
touch ${newConfFile}

# writeprotected files
if [ ${protected} -eq 1 ]; then
	sudo cp ${confFile} ${oldConfFile}
	sudo chmod a=rw ${oldConfFile}

	sudo ${awk}\
	 -f ${editConfig}\
	 -v begin_marker="${begin_marker}"\
	 -v end_marker="${end_marker}"\
	 -v new_section="${new_section}"\
	 <${oldConfFile} >${newConfFile}

	sudo mv -f ${newConfFile} ${confFile}
	sudo chmod gu-w-r ${confFile}
# Non-writeprotected files
else
	cp ${confFile} ${oldConfFile}

	${awk}\
	 -f ${editConfig}\
	 -v begin_marker="${begin_marker}"\
	 -v end_marker="${end_marker}"\
	 -v new_section="${new_section}"\
	 <${oldConfFile} >${newConfFile}

	mv -f ${newConfFile} ${confFile}
fi

rm ${oldConfFile}
