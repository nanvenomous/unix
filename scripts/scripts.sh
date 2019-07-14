#!/bin/bash
hr="${HOME}/scripts"
pylib="${hr}/src/pylib/run.sh"

to_link="${hr}/to_link.py"

#sources_not_linked=($(python3 "${to_link}"))
# "${pylib}" caller "${to_link}" get_unlinked_sources
sources_not_linked=($("${pylib}" caller "${to_link}" get_unlinked_sources))

# function forEachSymLink() {
	# operation=($1)
	# for file in "${array[@]}"; do   # The quotes are necessary here
		# link="${file/${filePath}/${exeDir}}"
		# link="${link/%.*/}"
		# echo "${file} <--> ${link}"
		# ${operation} ${file} ${link}
	# done
# }

echo ${sources_not_linked[@]}
