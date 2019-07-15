#!/bin/bash
hr="${HOME}/scripts"


to_link="${hr}/to_link.py"
pylib="${hr}/src/pylib/pylib.sh"

sources_not_linked=($("${pylib}" caller "${to_link}" get_unlinked_sources))
executables_to_clean=($("${pylib}" caller "${to_link}" get_executables_to_clean))

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

function destroy() {
	name="${1}"
	link="${exeDir}/${name}"
	rm "${link}"
}

function doForEach() {
	operation=($1)
	local -n array=$2
	for element in "${array[@]}"; do
		${operation} ${element}
	done
}


doForEach destroy executables_to_clean
doForEach link sources_not_linked