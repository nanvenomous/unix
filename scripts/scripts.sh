#!/bin/bash
hr="${HOME}/scripts"


to_link="${hr}/to_link.py"
pylib="${hr}/src/pylib/pylib.sh"

all_sources=($("${pylib}" caller "${to_link}" get_all_sources))
sources_not_linked=($("${pylib}" caller "${to_link}" get_unlinked_sources))
executables_to_clean=($("${pylib}" caller "${to_link}" get_executables_to_clean))

srcDir="${hr}/src"
exeDir="${hr}/bin"

mkdir -p "${exeDir}"

# will create a symlink in the bin dir using the file name
function link_file_to_executable() {
	name="${1}"
	file="${srcDir}/${name}/${name}.sh"
	link="${exeDir}/${name}"
	echo "${file} <--> ${link}"

	# create the link
	ln -s ${file} ${link}
}

function give_source_priveleges() {
	name="${1}"
	file="${srcDir}/${name}/${name}.sh"
	# make the file executable
	chmod +x ${file}
}

function destroy_extra_executable() {
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


doForEach destroy_extra_executable executables_to_clean
doForEach give_source_priveleges all_sources
doForEach link_file_to_executable sources_not_linked