#!/bin/bash
hr="${HOME}/scripts"


to_link="${hr}/to_link.py"
py="${hr}/src/py/py.sh"

sources_not_linked=($("${py}" caller "${to_link}" get_unlinked_sources))

srcDir="${hr}/src"
exeDir="${hr}/bin"

# will create a symlink in the bin dir using the file name
function link() {
	name="${1}"
	file="${srcDir}/${name}/${name}.sh"
	link="${exeDir}/${name}"
	echo "${file} <--> ${link}"

	# make the file executable
	chmod +x ${file}
	# create the link
	sudo ln -s ${file} ${link}
}

function doForEach() {
	operation=($1)
	local -n array=$2
	echo ${array[@]}
	for element in "${array[@]}"; do
		${operation} ${element}
	done
}


doForEach link sources_not_linked