#!/bin/bash
hr="${HOME}/scripts"

to_link="${hr}/to_link.py"
py="${hr}/src/py/py.sh"

sources_not_linked=($("${py}" caller "${to_link}" get_unlinked_sources))
echo ${sources_not_linked[@]}

# function forEachSymLink() {
	# operation=($1)
	# for file in "${array[@]}"; do   # The quotes are necessary here
		# link="${file/${filePath}/${exeDir}}"
		# link="${link/%.*/}"
		# echo "${file} <--> ${link}"
		# ${operation} ${file} ${link}
	# done
# }
